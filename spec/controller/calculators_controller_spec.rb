require 'rails_helper'

RSpec.describe CalculatorsController, type: :controller do
  let(:input) { "//:\n1:2\n:33:2" }
  let(:operation) { "add" }
  let(:variant) { "string_calculator" }
  let(:calculator_params) { { input: input, operation: operation, variant: variant } }

  describe 'POST #calculate' do
    context 'when the variant is valid' do
      it 'calculates the sum and returns the result' do
        post :calculate, params: { calculator: calculator_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['result']).to eq("4.0")  # Sum of 1 and 3 with custom delimiter ':'
      end
    end

    context 'when the variant is invalid' do
      let(:variant) { 'invalid_variant' }

      it 'returns an error message' do
        post :calculate, params: { calculator: calculator_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
