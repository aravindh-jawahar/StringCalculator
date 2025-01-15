class CalculatorsController < ApplicationController

  def calculate
    begin
      calculator = Calculator.new(validate_calculator_params).becomes_specific_calculator
      if calculator.save
        calculator.perform!
        render json: { result: calculator.result }
      else
        render json: { errors: calculator.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  private

  def validate_calculator_params
    params.require(:calculator).permit(:input, :variant, :operation)
  end
end
