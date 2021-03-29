FactoryBot.define do
  factory :quarter_project, class: 'Quarter::Project' do
    association :quarter
    title { 'Test Quarter Project One' }
    max_score { 100 }
  end
end
