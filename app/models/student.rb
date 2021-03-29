class Student < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  belongs_to :section
  has_many :homeworks, dependent: :destroy
  has_many :seatworks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :absents, dependent: :destroy
end
