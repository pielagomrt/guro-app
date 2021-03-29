FactoryBot.define do
  factory :section do
    association :teacher
    association :grading_system
    name { 'SectionName' }
    active_quarter { 1 }
  end
end
