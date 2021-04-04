class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subject, presence: true
  # validates :password, presence: true
  has_many :grading_systems, dependent: :destroy
  has_many :sections, dependent: :destroy
end
