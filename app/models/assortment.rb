class Assortment < ActiveRecord::Base
  belongs_to :product
  belongs_to :store

  validates :product, :store, presence: true
  validates :product_id, uniqueness: { scope: :store_id }
end
