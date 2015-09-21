class Store < ActiveRecord::Base
  has_many :assortments, dependent: :restrict_with_exception

  validates :name, presence: true

  def to_s
    name
  end
end
