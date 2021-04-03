FactoryBot.define do
  factory :quarter do
    association :section
    school_year { '2020-2021' }
    sequence(:sequence) { 1 }
  end
end
