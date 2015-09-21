class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :assortments, dependent: :destroy
  has_many :stores, through: :assortments

  validates :brand, :category, :name, presence: true

  monetize :price_cents, as: :price

  def to_s
    name
  end
end
