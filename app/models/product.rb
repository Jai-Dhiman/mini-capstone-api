class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :description, length: { minimum: 2, maximum: 500}

  belongs_to :supplier
  has_many :images, dependent: :destroy

  def is_discounted?
    price <= 10
  end

  def tax
    price * 0.09
  end

  def total
    price + (price * 0.09)
  end
end
