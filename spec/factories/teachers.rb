FactoryBot.define do
  factory :teacher do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.safe_email }
    password { '987654321' }
    subject { %w[Chemistry Calculus Biology History Filipino].sample }

    factory :teacher_with_sections do
      transient do
        section_count { 3 }
      end

      after(:create) do |teacher, evaluator|
        create_list(:section, evaluator.section_count, teacher: teacher)
        teacher.reload
      end
    end
  end
end
