# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    @order = current_user.orders.new
    @carted_products = current_user.carted_products.where(status: "in_cart")
    
    if @carted_products.any? && @order.save
      @carted_products.update_all(status: "purchased", order_id: @order.id)
      @order.calculate_totals
      render json: @order, include: { carted_products: { include: :product } }, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
    render json: @order, include: { carted_products: { include: :product } }
  end
end