# VinUtils

A gem to check and suggest [VIN](https://en.wikipedia.org/wiki/Vehicle_identification_number) identifiers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vin_utils'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install vin_utils

## Usage

You can use this gem in your code to check the validity of a given VIN.

```ruby
input_vin = '11111111111111111'
validator = VinUtils::Validator.new(input_vin)
validator.valid? # true
validator.calculate_check_digit # "1"
validator.suggest_valid_vin # "11111111111111111"
```

> Both `calculate_check_digit` and `suggest_valid_vin` will return `:invalid` incase of an invalid input (invalid characters, size or data type).

## Example

There is an example console application that can be run by typing:

```bash
bin/example <VIN>
```

And it will print to the console something like the example below:

```bash
Provided VIN: <VIN>
Check Digit: VALID
This looks like a VALID VIN!
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
