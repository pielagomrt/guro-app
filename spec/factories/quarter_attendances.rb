FactoryBot.define do
  factory :quarter_attendance, class: 'Quarter::Attendance' do
    association :quarter
    title { 'Test Quarter Attendance One' }
    date { '2020-03-31' }
  end
end
