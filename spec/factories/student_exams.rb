FactoryBot.define do
  factory :student_exam, class: 'Student::Exam' do
    association :student
    association :quarter
    association :quarter_exam
    score { 80 }
  end
end
