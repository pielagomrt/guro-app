FactoryBot.define do
  factory :section do
    association :teacher
    association :grading_system
    name { Faker::Ancient.god }
    active_quarter { 1 }

    factory :section_with_students do
      transient do
        students_count { 20 }
        quarters_count { 1 }
      end

      after(:create) do |section, evaluator|
        create_list(:student, evaluator.students_count, section: section)
        create_list(:quarter, evaluator.quarters_count, section: section)
        section.reload
      end
    end
  end
end
