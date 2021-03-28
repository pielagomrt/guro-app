class Quarter::Attendance < ApplicationRecord
  validates :date, presence: true
end
