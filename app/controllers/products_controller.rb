class ProductsController < ApplicationController
  def index
    @products = Product.all
    render template: "products/index"
  end

  def show
    @product = Product.find_by(id: params["id"])
    render template: "products/show"
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      inventory: params[:inventory],
      supplier_id: params[:supplier_id],
      image_url: params[:image_url]
    )
    if @product.save
      render template: "products/show"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.image_url = params[:image_url] || @product.image_url
    @product.description = params[:description] || @product.description
    @product.supplier_id = params[:supplier_id] || @product.supplier_id
    @product.save
    render template: "products/show"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    if @product
      @product.destroy
      render json: { message: "product has been removed" }
    else
    render json: { message: "product not found" }, status: :not_found
    end
  end
end
