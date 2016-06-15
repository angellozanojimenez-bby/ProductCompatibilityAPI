class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: true, presence: true
  validates :employee_number, numericality: { greater_than_or_equal_to: 0 }, presence: true
  
end
