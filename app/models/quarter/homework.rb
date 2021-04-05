class Quarter::Homework < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
  belongs_to :quarter
  has_many :student_homeworks, dependent: :destroy, class_name: 'Student::Homework', inverse_of: :quarter_homework, foreign_key: :quarter_homework_id
end
