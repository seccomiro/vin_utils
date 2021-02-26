module VinUtils
  class Validator
    DIGIT_BASE = %w[0 1 2 3 4 5 6 7 8 9 . A B C D E F G H . . J K L M N . P . R . . S T U V W X Y Z].freeze
    MAP = %w[0 1 2 3 4 5 6 7 8 9 X].freeze
    WEIGHTS = [8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    def initialize(vin)
      @vin = vin
    end

    def validate
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

    private

    def transliterate(char)
      DIGIT_BASE.index(char) % 10
    end

    def valid_input?
      return false unless @vin.instance_of?(String)
      return false if @vin.chars.size != 17

      @vin.chars.all? {|char| DIGIT_BASE.include?(char) }
    end
  end
end
