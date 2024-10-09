class CartedProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :status, presence: true, inclusion: { in: %w(in_cart purchased removed) }
end
