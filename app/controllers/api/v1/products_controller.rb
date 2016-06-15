class Api::V1::ProductsController < ApplicationController
  respond_to :json

  # Simple index to return all of the Products in a query.
  def index
    respond_with Product.all
  end
  # Show will return a product that matches the parameters passed into it.
  def show
    respond_with Product.find(params[:id])
  end
  # Create a new Product instance and if successfully created, then return
  # a 201 status, otherwise, return a 422 status.
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 201, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end
  # Find a Product instance by the parameters passed and then try to update
  # the product with the new paramters passed in, if successfully updated,
  # return a 200 response, otherwise, return a 422.
  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product, status: 200, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end
  # Find a Product instance by the parameters and destroy it.
  def destroy
    product = Product.find(params[:id])
    product.destroy
    head 204
  end

  private

    def product_params
      params.require(:product).permit(:title, :maker, :sku_number)
    end
end
