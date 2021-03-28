class Quarter::Exam < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
end
