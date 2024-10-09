class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}

  belongs_to :supplier
  has_many :carted_products
  has_many :images, dependent: :destroy
  has_many :orders

end
