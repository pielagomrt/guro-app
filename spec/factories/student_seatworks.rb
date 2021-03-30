FactoryBot.define do
  factory :student_seatwork, class: 'Student::Seatwork' do
    association :student
    association :quarter
    association :quarter_seatwork
    score { 80 }
  end
end
