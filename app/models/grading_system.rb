class GradingSystem < ApplicationRecord
  include ActiveModel::Validations
  validates_with Validators::GradingSystemTotal
  validates :homework, presence: true
  validates :seatwork, presence: true
  validates :project, presence: true
  validates :exam, presence: true
  validates :attendance, presence: true
  belongs_to :teacher
  has_many :sections, dependent: :nullify
end
