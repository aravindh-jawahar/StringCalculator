require 'rails_helper'

RSpec.describe Calculator, type: :model do
  let(:input) { "2,6" }
  let(:calculator) { FactoryBot.create(:calculator, input: input, variant: variant) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:variant) }
  end

  context 'when string_calculator variant is specified' do
    let(:variant) { 'string_calculator' }
    
    it 'creates string_calculator record' do
      calculator.becomes_specific_calculator
      expect(calculator.variant).to eq('string_calculator')
    end
  end

  context 'when incorrect variant is specified' do
    let(:variant) { 'ss' }
    
    it 'creates string_calculator record' do
      calculator
      expect(calculator.variant).to eq('ss')
      expect { calculator.becomes_specific_calculator }.to raise_error(NameError)
    end
  end
end
