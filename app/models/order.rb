class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def subtotal
    price * quantity
  end

  def tax
    subtotal * 0.09
  end

  def total
    subtotal + (subtotal * 0.09)
  end
end
