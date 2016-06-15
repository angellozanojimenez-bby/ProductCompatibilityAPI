class Relation < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :relation_type, presence: true
  validates :sku_one, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :sku_two, numericality: { greater_than_or_equal_to: 0 }, presence: true
  
end
