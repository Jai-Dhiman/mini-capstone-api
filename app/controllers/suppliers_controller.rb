class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
    render template: "supplier/index"
  end

  def show
    @suppliers = Supplier.find_by(id: params["id"])
    render template: "suppliers/show"
  end

  def create
    @suppliers = Supplier.new(
      name: params[:name],
      email: params[:email],
      phone_number: params[:phone_number],
    )
    if @suppliers.save
      render template: "suppliers/show"
    else
      render json: {errors: @suppliers.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @suppliers = Supplier.find_by(id: params[:id])
    @suppliers.name = params[:name] || @suppliers.name
    @suppliers.email = params[:email] || @suppliers.email
    @suppliers.phone_number = params[:phone_number] || @suppliers.phone_number
    @suppliers.save
    render template: "suppliers/show"
  end

  def destroy
    @suppliers = Supplier.find_by(id: params[:id])
    @suppliers.destroy
    render json: { message: "product has been removed" }
  end
end
