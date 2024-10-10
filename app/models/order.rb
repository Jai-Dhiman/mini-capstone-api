class Order < ApplicationRecord
  belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  def calculate_totals
    self.subtotal = carted_products.sum { |cp| cp.product.price * cp.quantity }
    self.tax = subtotal * 0.09
    self.total = subtotal + tax
  end

  def complete_order
    calculate_totals
    carted_products.update_all(status: "purchased")
  end
end