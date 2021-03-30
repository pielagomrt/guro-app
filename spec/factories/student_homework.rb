FactoryBot.define do
  factory :student_homework, class: 'Student::Homework' do
    association :student
    association :quarter
    association :quarter_homework
    score { 80 }
  end
end
