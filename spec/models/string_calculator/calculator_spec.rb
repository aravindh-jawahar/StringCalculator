require 'rails_helper'

RSpec.describe StringCalculator::Calculator, type: :model do
  let(:input) { "2,6" }
  let(:calculator) { FactoryBot.create(:calculator, input:, variant:).becomes(StringCalculator::Calculator) }
  let(:variant) { 'string_calculator' }
  describe '#perform!' do

    context 'when the variant is valid' do
      it  'creates a new calculator record and perform the add operation' do
        calculator.perform!
        expect(calculator.result).to eq(8)
      end
    end

    context 'when incorrect variant is specified' do
      let(:variant) { 'invalid' }
      
      it 'creates string_calculator record' do
        calculator
        expect(calculator.variant).to eq('invalid')
        expect { calculator.becomes_specific_calculator }.to raise_error(NameError)
      end
    end
  end
end
