FactoryBot.define do
  factory :student do
    association :section
    first_name { 'Test' }
    last_name { 'Student' }
    email { Faker::Internet.safe_email }
  end
end
