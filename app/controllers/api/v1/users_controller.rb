class Api::V1::UsersController < ApplicationController
  respond_to :json

  # Find user by the parameters into the function.
  def show
    respond_with User.find(params[:id])
  end
  # Create user from the parameters passed into the user create method.
  # If successfully created, then return a 201 status, 422 otherwise.
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

private
  # These are the user params that are required to create a new user instance/
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :employee_number)
  end

end
