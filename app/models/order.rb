class Order < ApplicationRecord
  belongs_to :user
  has_many :carted_products
  has_many :product, through: :carted_products
  validates :subtotal, :tax, :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def calculate_totals(carted_products)
    subtotal = carted_products.sum { |cp| cp.product.price * cp.quantity }
    tax = subtotal * 0.09
    total = subtotal + tax

    self.subtotal = subtotal
    self.tax = tax
    self.total = total
  end
end
