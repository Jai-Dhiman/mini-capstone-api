class CartedProductsController < ApplicationController
  before_action :authenticate_user

  def index
    @carted_products = current_user.carted_products.where(order_id: nil)
    render json: @carted_products, include: :product
  end

  def create
    @carted_product = CartedProduct.new(
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "in_cart"
    )
    if @carted_product.save
      render json: @carted_product, status: :created
    else
      render json: { errors: @carted_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @carted_product = current_user.carted_products.find(params[:id])
    if @carted_product.update(quantity: params[:quantity])
      render json: @carted_product
    else
      render json: { errors: @carted_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @carted_product = current_user.carted_products.find(params[:id])
    @carted_product.update(status: "removed")
    render json: { message: "Carted product successfully removed" }
  end

end