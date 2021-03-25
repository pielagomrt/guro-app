class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 

  validates :firstname, presence: true   
  validates :lastname, presence: true   
  validates :email, presence: true
  validates :password, presence: true

end
