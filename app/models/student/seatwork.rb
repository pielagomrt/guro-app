class Student::Seatwork < ApplicationRecord
  validates :score, presence: true
  belongs_to :student
  belongs_to :quarter, inverse_of: :student_seatworks
  belongs_to :quarter_seatwork, class_name: 'Quarter::Seatwork', inverse_of: :student_seatworks
end
