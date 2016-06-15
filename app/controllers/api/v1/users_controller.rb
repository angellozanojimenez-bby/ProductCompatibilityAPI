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
  # We find the user by the parameters passed, we then try to update that
  # user using the update method and the parameters passed. If successfully
  # updated, respond with a 200, 422 otherwise.
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end

  end
  # We find the user by the parameters passed, we then destroy the object.
  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private
    # These are the user params that are required to create a new user instance/
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :employee_number)
    end

end
