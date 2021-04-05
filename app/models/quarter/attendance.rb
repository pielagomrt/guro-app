class Quarter::Attendance < ApplicationRecord
  validates :date, presence: true
  belongs_to :quarter
  has_many :student_absents, dependent: :destroy, class_name: 'Student::Absent', inverse_of: :quarter_attendance, foreign_key: :quarter_attendance_id
end
