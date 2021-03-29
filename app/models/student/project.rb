class Student::Project < ApplicationRecord
  validates :score, presence: true
end
