class Api::V1::UsersController < ApplicationController
  respond_to :json

  # Find user by the parameters into the function.
  def show
    respond_with User.find(params[:id])
  end
  
end
