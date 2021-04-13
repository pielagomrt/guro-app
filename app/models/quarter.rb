class Quarter < ApplicationRecord
  include ActiveModel::Validations
  validates_with Validators::QuarterSchoolYear
  validates :sequence, inclusion: 1..4
  belongs_to :section
  has_many :homeworks, dependent: :destroy
  has_many :seatworks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :student_homeworks, dependent: :destroy, class_name: 'Student::Homework'
  has_many :student_seatworks, dependent: :destroy, class_name: 'Student::Seatwork'
  has_many :student_projects, dependent: :destroy, class_name: 'Student::Project'
  has_many :student_exams, dependent: :destroy, class_name: 'Student::Exam'
  has_many :student_absents, dependent: :destroy, class_name: 'Student::Absent'
end
