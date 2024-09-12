class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :description, length: { minimum: 2, maximum: 500}

  belongs_to :supplier
  has_many :images, dependent: :destroy
  has_many :orders

end
