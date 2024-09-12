class OrdersController < ApplicationController

  def index
    @orders = Order.all
    render :index
  end

  def show 
    @orders = Order.find_by(id: params[:id])
    render :show
  end

  def create
    @orders = Order.new(
      user_id: params[:user_id],
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: params[:subtotal],
      tax: params[:tax],
      total: params[:total],
    )

    if @orders.save
      render :show
    else
      render json: {errors: @orders.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
