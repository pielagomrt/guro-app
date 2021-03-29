class Quarter::Project < ApplicationRecord
  validates :title, presence: true
  validates :max_score, presence: true
end
