class Product < ApplicationRecord
  belongs_to :supplier
  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :images, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :supplier, presence: true
end
