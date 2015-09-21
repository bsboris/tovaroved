class Category < ActiveRecord::Base
  has_many :products, dependent: :restrict_with_exception

  scope :ordered_by_name, -> { order(:name) }

  validates :name, presence: true

  def to_s
    name
  end
end
