class GradingSystem < ApplicationRecord
  include ActiveModel::Validations
  validates_with Validators::GradingSystem
  validates :homework, presence: true
  validates :seatwork, presence: true
  validates :project, presence: true
  validates :exam, presence: true
  validates :attendance, presence: true
end
