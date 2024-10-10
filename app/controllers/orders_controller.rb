class OrdersController < ApplicationController
  def create
    @order = current_user.orders.new
    @order.carted_products = current_user.carted_products.in_cart
    
    if @order.carted_products.any? && @order.complete_order && @order.save
      render json: @order, include: { carted_products: { include: :product } }
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
