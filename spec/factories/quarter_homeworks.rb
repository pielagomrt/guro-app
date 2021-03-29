FactoryBot.define do
  factory :quarter_homework, class: 'Quarter::Homework' do
    association :quarter
    title { 'Test Quarter Homework One' }
    max_score { 100 }
  end
end
