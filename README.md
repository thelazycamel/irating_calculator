## Irating Calculator

Ruby interpretation of the iRating Strength of Field Calculator

This repo is based on the [iRacing SOF iRating Calculator v1_1.xlsx](https://github.com/SIMRacingApps/SIMRacingApps/files/3617438/iRacing.SOF.iRating.Calculator.v1_1.xlsx)
with help from the rust version
[github.com/Turbo87/irating-rs/](github.com/Turbo87/irating-rs/)


## Installation

Add this line to your application's Gemfile:

    gem 'irating_calculator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install irating_calculator

## Usage

  require 'irating_calculator'

  drivers =
    [
      { driver_id: 'driver_1', position: 1, old_irating: 7526, dns: false },
      { driver_id: 'driver_2', position: 2, old_irating: 5982, dns: false }...
    ]

  calc = IratingCalculator.new(drivers)

  calc.calculate!

  calc.sof

  results = calc.irating_results

  driver = results.first

  driver.expected_score

  driver.expected_position

  driver.irating_change

  driver.new_irating

