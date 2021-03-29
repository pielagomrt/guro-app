class Student::Project < ApplicationRecord
  validates :score, presence: true
  belongs_to :student
  belongs_to :quarter, inverse_of: :student_projects
  belongs_to :quarter_project, class_name: 'Quarter::Project', inverse_of: :student_projects
end
