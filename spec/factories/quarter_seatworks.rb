FactoryBot.define do
  factory :quarter_seatwork, class: 'Quarter::Seatwork' do
    association :quarter
    title { 'Test Quarter Seatwork One' }
    max_score { 100 }
  end
end
