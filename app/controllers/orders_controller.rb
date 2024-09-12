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
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
    )

    if @orders.save
      render :show
    else
      render json: {errors: @orders.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
