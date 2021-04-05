class Quarter::Exam < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
  belongs_to :quarter
  has_many :student_exams, dependent: :destroy, class_name: 'Student::Exam', inverse_of: :quarter_exam, foreign_key: :quarter_exam_id
end
