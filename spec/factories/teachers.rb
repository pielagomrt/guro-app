FactoryBot.define do
  factory :teacher do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    email { Faker::Internet.safe_email }
    password { '987654321' }
    subject { %w[Chemistry Calculus Biology History Filipino].sample }
  end
end
