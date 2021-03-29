class Student::Homework < ApplicationRecord
  validates :score, presence: true
end
