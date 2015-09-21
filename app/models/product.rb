class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  validates :brand, :category, :name, presence: true
end
