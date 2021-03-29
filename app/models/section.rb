class Section < ApplicationRecord
  validates :name, presence: true
  validates :active_quarter, presence: true
  belongs_to :teacher
  belongs_to :grading_system
  has_many :students, dependent: :destroy
  has_many :quarters, dependent: :destroy
end
