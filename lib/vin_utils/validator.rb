module VinUtils
  class Validator
    attr_accessor :vin

    DIGIT_BASE = %w[0 1 2 3 4 5 6 7 8 9 . A B C D E F G H . . J K L M N . P . R . . S T U V W X Y Z].freeze
    MAP = %w[0 1 2 3 4 5 6 7 8 9 X].freeze
    WEIGHTS = [8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    def initialize(vin)
      @vin = vin
      @vin = @vin.upcase if @vin.instance_of?(String)
    end

    def valid?
      return false unless valid_input?

      calculate_check_digit == @vin[8]
    end

    def calculate_check_digit
      return :invalid unless valid_input?

      sum = 0
      @vin.chars.each_with_index do |char, i|
        sum += transliterate(char) * WEIGHTS[i]
      end

      MAP[sum % 11]
    end

    def suggest_valid_vin
      return :invalid unless valid_input?
      return @vin if valid?

      new_vin = @vin.dup
      new_vin[8] = calculate_check_digit
      new_vin
    end

    private

    def transliterate(char)
      DIGIT_BASE.index(char) % 10
    end

    def valid_input?
      return false unless @vin.instance_of?(String)
      return false if @vin.chars.size != 17

      @vin.chars.all? do |char|
        DIGIT_BASE.include?(char) && char != '.'
      end
    end
  end
end
