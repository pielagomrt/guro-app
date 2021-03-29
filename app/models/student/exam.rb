class Student::Exam < ApplicationRecord
  validates :score, presence: true
  belongs_to :student
  belongs_to :quarter, inverse_of: :student_exams
  belongs_to :quarter_exam, class_name: 'Quarter::Exam', inverse_of: :student_exams
end
