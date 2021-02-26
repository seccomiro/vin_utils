require 'vin_utils/validator'

RSpec.describe VinUtils::Validator do
  let(:vins) do
    {
      valid: %w[1XPTD40X6JD456115 2NKWL00X16M149834 1XKYDPPX4MJ442156],
      invalid_characters: %w[INKDLUOX33R385016 INKDLUOX33R385016],
      invalid_check_digit: [
        {vin: '1XPBDP9X1FD257820', valid_check_digit: '8', valid_vin: '1XPBDP9X8FD257820'},
        {vin: '3HSDJAPRSFN657165', valid_check_digit: '5', valid_vin: '3HSDJAPR5FN657165'},
        {vin: 'JBDCUB16657005393', valid_check_digit: '8', valid_vin: 'JBDCUB16857005393'}
      ],
      invalid_size: ['ABC', 'ABCABCABCABCABCABC', ''],
      invalid_type: [132, [], {}, nil, :abc]
    }
  end

  describe '.calculate_check_digit' do
    context 'with valid VINs' do
      it 'returns the same check digit' do
        vins[:valid].each do |vin|
          expect(VinUtils::Validator.new(vin).calculate_check_digit).to eq(vin.chars[8])
        end
      end
    end

    context 'with invalid VINs' do
      context 'invalid characters' do
        it 'returns :invalid' do
          vins[:invalid_characters].each do |vin|
            expect(VinUtils::Validator.new(vin).calculate_check_digit).to eq :invalid
          end
        end
      end

      context 'invalid check digit' do
        it 'returns a valid check digit' do
          vins[:invalid_check_digit].each do |vin|
            expect(VinUtils::Validator.new(vin[:vin]).calculate_check_digit).to eq(vin[:valid_check_digit])
          end
        end
      end

      context 'invalid size' do
        it 'returns :invalid' do
          vins[:invalid_size].each do |vin|
            expect(VinUtils::Validator.new(vin).calculate_check_digit).to eq :invalid
          end
        end
      end

      context 'invalid type' do
        it 'returns :invalid' do
          vins[:invalid_type].each do |vin|
            expect(VinUtils::Validator.new(vin).calculate_check_digit).to eq :invalid
          end
        end
      end
    end
  end

  describe '.validate' do
    context 'with valid VINs' do
      it 'returns true' do
        vins[:valid].each do |vin|
          expect(VinUtils::Validator.new(vin).validate).to be true
        end
      end
    end

    context 'with invalid VINs' do
      context 'invalid characters' do
        it 'returns false' do
          vins[:invalid_characters].each do |vin|
            expect(VinUtils::Validator.new(vin).validate).to be false
          end
        end
      end

      context 'invalid check digit' do
        it 'returns false' do
          vins[:invalid_check_digit].each do |vin|
            expect(VinUtils::Validator.new(vin[:vin]).validate).to be false
          end
        end
      end

      context 'invalid size' do
        it 'returns false' do
          vins[:invalid_size].each do |vin|
            expect(VinUtils::Validator.new(vin).validate).to be false
          end
        end
      end

      context 'invalid type' do
        it 'returns false' do
          vins[:invalid_type].each do |vin|
            expect(VinUtils::Validator.new(vin).validate).to be false
          end
        end
      end
    end
  end
end