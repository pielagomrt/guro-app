class Quarter::Project < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
  belongs_to :quarter
  has_many :student_projects, dependent: :destroy, class_name: 'Student::Project', inverse_of: :quarter_project, foreign_key: :quarter_project_id
end
