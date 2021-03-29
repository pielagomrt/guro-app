FactoryBot.define do
  factory :grading_system do
    association :teacher
    homework { 20 }
    seatwork { 20 }
    exam { 20 }
    project { 20 }
    attendance { 20 }
  end
end
