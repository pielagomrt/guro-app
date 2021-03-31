FactoryBot.define do
  factory :student do
    association :section
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.safe_email }
  end
end
