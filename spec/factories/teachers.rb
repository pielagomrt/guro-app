FactoryBot.define do
  factory :teacher do
    first_name { 'Test' }
    last_name { 'Teacher' }
    email { Faker::Internet.safe_email }
    password { '987654321' }
    subject { 'Science' }
  end
end
