class Section < ApplicationRecord
  validates :name, presence: true
  validates :active_quarter, presence: true
end
