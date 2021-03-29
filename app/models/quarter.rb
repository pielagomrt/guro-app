class Quarter < ApplicationRecord
  include ActiveModel::Validations
  validates_with Validators::QuarterSchoolYear
  validates :sequence, numericality: { only_integer: { in: 1..4 } }
  validates :max_attendance, presence: true
end
