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
    carted_products = current_user.carted_products.where(status: "in_cart")
    
    @order = Order.new(user_id: current_user.id)
    @order.calculate_totals(carted_products)
  
    if @order.save
      carted_products.update_all(order_id: @order.id)
      render :show
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end
  end
end
