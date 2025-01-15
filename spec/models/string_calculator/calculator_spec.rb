require 'rails_helper'

RSpec.describe StringCalculator::Calculator, type: :model do
  let(:calculator) { FactoryBot.create(:calculator, input:, variant:).becomes(StringCalculator::Calculator) }
  let(:variant) { 'string_calculator' }

  describe '#perform!' do
    context 'when the variant is valid' do
      context 'with input "1,2"' do
        let(:input) { "1,2" }

        it 'returns the correct sum' do
          calculator.perform!
          expect(calculator.result).to eq(3)
        end
      end

      context 'with input "1\\n,2\\n"' do
        let(:input) { "1\n,2\n" }

        it 'returns the correct sum' do
          calculator.perform!
          expect(calculator.result).to eq(3)
        end
      end

      context 'with input "//:\\n1\\n,5"' do
        let(:input) { "//:\n1\n,5" }

        it 'returns the correct sum' do
          calculator.perform!
          expect(calculator.result).to eq(6)
        end
      end

      context 'with input "//:\\n1:2\\n33:2"' do
        let(:input) { "//:\n1:2\n33:2" }

        it 'returns the correct sum' do
          calculator.perform!
          expect(calculator.result).to eq(38)
        end
      end
    end

    context 'when incorrect variant is specified' do
      let(:variant) { 'invalid' }
      let(:input) { "1,2" }

      it 'creates a record with the invalid variant and raises an error' do
        calculator
        expect(calculator.variant).to eq('invalid')
        expect { calculator.becomes_specific_calculator }.to raise_error(NameError)
      end
    end
  end
end
