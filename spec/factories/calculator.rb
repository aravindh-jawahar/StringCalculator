FactoryBot.define do
  factory :calculator do
    variant { 'string_calculator' }
    operation { 'add' }
  end
end
