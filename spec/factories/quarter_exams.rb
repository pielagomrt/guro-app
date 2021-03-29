FactoryBot.define do
  factory :quarter_exam, class: 'Quarter::Exam' do
    association :quarter
    title { 'Test Quarter Exam One' }
    max_score { 100 }
  end
end
