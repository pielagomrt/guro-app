class Student::Exam < ApplicationRecord
  validates :score, presence: true
end
