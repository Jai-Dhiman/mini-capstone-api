class Product < ApplicationRecord
  belongs_to :supplier
  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
