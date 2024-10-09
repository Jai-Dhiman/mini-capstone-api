class CartedProductsController < ApplicationController
  def create
    @carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity]
    )
    if @carted_product.save
      render json: @carted_product, status: :created
    else
      render json: { errors: @carted_product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def index
    @carted_products = current_user.carted_products.where(order_id: nil)
    render template: "carted_products/index"
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
    render json: { message: "Carted product successfully removed" }
  end

end