FactoryBot.define do
  factory :quarter do
    association :section
    school_year { '2020-2021' }
    max_attendance { 80 }
    sequence(:sequence) { 2 }
  end
end
