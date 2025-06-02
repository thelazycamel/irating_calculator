# frozen_string_literal: true

# A simple class to calculate drivers iratings using an algorythm close to iracing
# IratingCalculator.new(drivers) where drivers should be an array of hashes:
# [{
#   :driver_id        (unique id)
#   :position         (integer - race position)
#   :old_irating  (float)
#   :dns              (boolean - did not start)
# }]
class IratingCalculator
  attr_accessor :irating_results, :k_factor, :number_of_drivers

  # Create a new object for each driver result including the passed attributes

  DriverResult = Struct.new(
    :driver_id,
    :position,
    :old_irating,
    :dns,
    :expected_position,
    :new_irating,
    :irating_change,
    :sof_exponential,
    :fudge_factor,
    :expected_score
  )

  # Note the k_factor defaults to 1600 but different values can be passed to adjust the exponential for special races.

  def initialize(drivers = [], k_factor = 1600)
    @irating_results = build_irating_results(drivers)
    @k_factor = k_factor
    @number_of_drivers = irating_results.size
  end

  # Call this method to calculate the results for every driver
  # It will create the @irating_results array of driverResult objects

  def calculate!
    irating_results.each do |driver|
      driver.sof_exponential = sof_exponential(driver)
      driver.fudge_factor = fudge_factor(driver)
      driver.expected_score = expected_score(driver)
      driver.irating_change = irating_change(driver)
      driver.new_irating = new_irating(driver)
      driver.expected_position = expected_position(driver)
    end
    self
  end

  # race_constant, this will always be the same unless you change the default k_factor

  def race_constant
    @race_constant ||= (k_factor / Math.log(2)).round(2)
  end

  # SOF (Strength of Field) calculation

  def sof
    @sof ||= (race_constant * Math.log(number_of_drivers / irating_results.map { |driver|
      sof_exponential(driver)
    }.sum)).round(2)
  end

  private

  def sof_exponential(driver)
    Math.exp(-driver.old_irating / race_constant)
  end

  def fudge_factor(driver)
    (((number_of_drivers / 2.0) - driver.position) / 100.0)
  end

  def expected_score(driver)
    exps = irating_results.map(&:old_irating).map do |irating|
      line1(driver, irating) / (line2(driver, irating) + line3(driver, irating))
    end
    exps.sum.round(2) - 0.5
  end

  def line1(driver, irating)
    (1 - Math.exp(-driver.old_irating / race_constant)) * Math.exp(-irating / race_constant)
  end

  def line2(driver, irating)
    (1 - Math.exp(-irating / race_constant)) * Math.exp(-driver.old_irating / race_constant)
  end

  def line3(driver, irating)
    (1 - Math.exp(-driver.old_irating / race_constant)) * Math.exp(-irating / race_constant)
  end

  def irating_change(driver)
    calculation = number_of_drivers - driver.position - driver.expected_score - driver.fudge_factor
    ((calculation * 200) / number_of_drivers).round(2)
  end

  def new_irating(driver)
    driver.old_irating + driver.irating_change
  end

  def expected_position(driver)
    (number_of_drivers - driver.expected_score).round(1)
  end

  def build_irating_results(driver_hash)
    driver_hash.map do |driver|
      DriverResult.new(
        driver[:driver_id],
        driver[:position],
        driver[:old_irating],
        driver[:dns]
      )
    end
  end
end
