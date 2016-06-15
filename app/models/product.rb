class Product < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :title, :maker, presence: true
  validates :sku_number, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
