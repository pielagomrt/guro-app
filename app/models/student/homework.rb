class Student::Homework < ApplicationRecord
  validates :score, presence: true
  belongs_to :student
  belongs_to :quarter, inverse_of: :student_homeworks
  belongs_to :quarter_homework, class_name: 'Quarter::Homework', inverse_of: :student_homeworks
end
