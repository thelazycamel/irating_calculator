# frozen_string_literal: true

require_relative '../lib/irating_calculator'

describe IratingCalculator do
  let(:drivers) do
    [
      { driver_id: 'driver_1', position: 1, old_irating: 7526, dns: false },
      { driver_id: 'driver_2', position: 2, old_irating: 5982, dns: false },
      { driver_id: 'driver_3', position: 3, old_irating: 5463, dns: false },
      { driver_id: 'driver_4', position: 4, old_irating: 4279, dns: false },
      { driver_id: 'driver_5', position: 5, old_irating: 4137, dns: false },
      { driver_id: 'driver_6', position: 6, old_irating: 4044, dns: false },
      { driver_id: 'driver_7', position: 7, old_irating: 3891, dns: false },
      { driver_id: 'driver_8', position: 8, old_irating: 3612, dns: false },
      { driver_id: 'driver_9', position: 9, old_irating: 3147, dns: false },
      { driver_id: 'driver_10', position: 10, old_irating: 2823, dns: false },
      { driver_id: 'driver_11', position: 11, old_irating: 2715, dns: false },
      { driver_id: 'driver_12', position: 12, old_irating: 2603, dns: false },
      { driver_id: 'driver_13', position: 13, old_irating: 2512, dns: false },
      { driver_id: 'driver_14', position: 14, old_irating: 2352, dns: false },
      { driver_id: 'driver_15', position: 15, old_irating: 2227, dns: false },
      { driver_id: 'driver_16', position: 16, old_irating: 2195, dns: false },
      { driver_id: 'driver_17', position: 17, old_irating: 2166, dns: false },
      { driver_id: 'driver_18', position: 18, old_irating: 2089, dns: false },
      { driver_id: 'driver_19', position: 19, old_irating: 1773, dns: false },
      { driver_id: 'driver_20', position: 20, old_irating: 1772, dns: false },
      { driver_id: 'driver_21', position: 21, old_irating: 1752, dns: false },
      { driver_id: 'driver_22', position: 22, old_irating: 1748, dns: false },
      { driver_id: 'driver_23', position: 22, old_irating: 1705, dns: false },
      { driver_id: 'driver_24', position: 24, old_irating: 1662, dns: false },
      { driver_id: 'driver_25', position: 25, old_irating: 1622, dns: false },
      { driver_id: 'driver_26', position: 26, old_irating: 1537, dns: false },
      { driver_id: 'driver_27', position: 27, old_irating: 1464, dns: false },
      { driver_id: 'driver_28', position: 28, old_irating: 1203, dns: false }
    ]
  end

  it 'should take a driver hash and convert it to an array of objects' do
    calc = described_class.new(drivers)
    expect(calc.irating_results.first.driver_id).to eq('driver_1')
  end

  it 'should have the number of drivers' do
    calc = described_class.new(drivers)
    expect(calc.number_of_drivers).to eq(28)
  end

  it 'should update the k_factor if passed' do
    calc = described_class.new(drivers, 2000)
    expect(calc.k_factor).to eq(2000)
  end

  it 'should calculate the race_constant' do
    calc = described_class.new(drivers)
    expect(calc.race_constant).to eq(2308.31)
  end

  it 'should calculate the sof' do
    calc = described_class.new(drivers)
    expect(calc.sof).to eq(2493.98)
  end

  describe '#calculate_iratings' do
    let(:calculator) { described_class.new(drivers).calculate! }

    context 'driver_1' do
      let(:driver) { calculator.irating_results.find { |d| d.driver_id == 'driver_1' } }

      it 'should calculate sof_expotencial for driver_1' do
        expect(driver.sof_exponential).to eq(0.03837327720047369)
      end

      it 'should calculate fudge_factor for driver_1' do
        expect(driver.fudge_factor).to eq(0.13)
      end

      it 'should calculate expected_score for driver_1' do
        expect(driver.expected_score).to eq(24.49)
      end

      it 'should calculate irating_change for driver_1' do
        expect(driver.irating_change).to eq(17)
      end

      it 'should calculate new_irating for driver_1' do
        expect(driver.new_irating).to eq(7543)
      end

      it 'should calculate expected_position for driver_1' do
        expect(driver.expected_position).to eq(3.5)
      end
    end

    context 'driver_2' do
      let(:driver) { calculator.irating_results.find { |d| d.driver_id == 'driver_2' } }

      it 'should calculate expected_position for driver_2' do
        expect(driver.expected_position).to eq(5.6)
      end

      it 'should calculate irating_change for driver_2' do
        expect(driver.irating_change).to eq(24.93)
      end

      it 'should calculate new_irating for driver_2' do
        expect(driver.new_irating).to eq(6006.93)
      end
    end

    context 'full results' do
      it 'should calculate for driver_3' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_3' }
        expect(driver.new_irating).to eq(5487.5)
      end

      it 'should calculate for driver_4' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_4' }
        expect(driver.new_irating).to eq(4315.57)
      end

      it 'should calculate for driver_5' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_5' }
        expect(driver.new_irating).to eq(4169.21)
      end

      it 'should calculate for driver_6' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_6' }
        expect(driver.new_irating).to eq(4070.93)
      end

      it 'should calculate for driver_7' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_7' }
        expect(driver.new_irating).to eq(3913.93)
      end

      it 'should calculate for driver_8' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_8' }
        expect(driver.new_irating).to eq(3633.79)
      end

      it 'should calculate for driver_9' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_9' }
        expect(driver.new_irating).to eq(3172.5)
      end

      it 'should calculate for driver_10' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_10' }
        expect(driver.new_irating).to eq(2849.71)
      end

      it 'should calculate for driver_11' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_11' }
        expect(driver.new_irating).to eq(2737.5)
      end

      it 'should calculate for driver_12' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_12' }
        expect(driver.new_irating).to eq(2621.5)
      end

      it 'should calculate for driver_13' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_13' }
        expect(driver.new_irating).to eq(2526.0)
      end

      it 'should calculate for driver_14' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_14' }
        expect(driver.new_irating).to eq(2363.57)
      end

      it 'should calculate for driver_15' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_15' }
        expect(driver.new_irating).to eq(2235.21)
      end

      it 'should calculate for driver_16' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_16' }
        expect(driver.new_irating).to eq(2197.14)
      end

      it 'should calculate for driver_17' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_17' }
        expect(driver.new_irating).to eq(2161.93)
      end

      it 'should calculate for driver_18' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_18' }
        expect(driver.new_irating).to eq(2080.21)
      end

      it 'should calculate for driver_19' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_19' }
        expect(driver.new_irating).to eq(1767.43)
      end

      it 'should calculate for driver_20' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_20' }
        expect(driver.new_irating).to eq(1759.36)
      end

      it 'should calculate for driver_21' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_21' }
        expect(driver.new_irating).to eq(1733.0)
      end

      it 'should calculate for driver_22' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_22' }
        expect(driver.new_irating).to eq(1722.0)
      end

      it 'should calculate for driver_23' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_23' }
        expect(driver.new_irating).to eq(1680.5)
      end

      it 'should calculate for driver_24' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_24' }
        expect(driver.new_irating).to eq(1624.79)
      end

      it 'should calculate for driver_25' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_25' }
        expect(driver.new_irating).to eq(1579.14)
      end

      it 'should calculate for driver_26' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_26' }
        expect(driver.new_irating).to eq(1490.07)
      end

      it 'should calculate for driver_27' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_27' }
        expect(driver.new_irating).to eq(1412.57)
      end

      it 'should calculate for driver_28' do
        driver = calculator.irating_results.find { |d| d.driver_id == 'driver_28' }
        expect(driver.new_irating).to eq(1154.21)
      end
    end
  end
end
