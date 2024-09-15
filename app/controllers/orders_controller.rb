class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
    render :index
  end

  def show 
    @orders = current_user.orders.find_by(id: params[:id])
    render :show
  end

  def create
    product = Product.find_by(id: params[:product_id])
    calculated_subtotal = product.price * params[:quantity].to_i
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax
    
    @orders = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total,
    )
    if @orders.save
      render :show
    else
      render json: {errors: @orders.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
