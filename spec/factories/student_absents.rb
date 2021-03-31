FactoryBot.define do
  factory :student_absent, class: 'Student::Absent' do
    association :student
    association :quarter
    association :quarter_attendance
  end
end
