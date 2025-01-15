class Calculator < ApplicationRecord

  delegate :perform!, to: :becomes_specific_calculator

  def becomes_specific_calculator
    raise 'Not implemented' if specific_calculator.blank?

    becomes(specific_calculator)
  end

  private

  def specific_calculator
    @specific_calculator ||= "#{variant.camelcase}::Calculator".constantize
  end

end
