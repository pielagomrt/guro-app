class Quarter::Seatwork < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
  belongs_to :quarter
  has_many :student_seatworks, dependent: :destroy, class_name: 'Student::Seatwork', inverse_of: :quarter_seatwork, foreign_key: :quarter_seatwork_id
end
