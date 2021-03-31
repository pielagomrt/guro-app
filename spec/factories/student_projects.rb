FactoryBot.define do
  factory :student_project, class: 'Student::Project' do
    association :student
    association :quarter
    association :quarter_project
    score { 80 }
  end
end
