class Brand < ActiveRecord::Base
  has_many :products, dependent: :restrict_with_exception

  validates :name, presence: true

  def to_s
    name
  end
end
