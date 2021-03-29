class Student::Absent < ApplicationRecord
  belongs_to :student
  belongs_to :quarter, inverse_of: :student_absents
  belongs_to :quarter_attendance, class_name: 'Quarter::Attendance', inverse_of: :student_absents
end
