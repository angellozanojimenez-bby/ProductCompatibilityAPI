class Api::V1::RelationsController < ApplicationController
  respond_to :json
  # Show will return a relation that matches the parameters passed into it.
  def show
    respond_with Relation.find(params[:id])
  end
  # Create a new Relation instance and if successfully created, then return
  # a 201 status, otherwise, return a 422 status.
  def create
    relation = Relation.new(relation_params)
    if relation.save
      render json: relation, status: 201, location: [:api, relation]
    else
      render json: { errors: relation.errors }, status: 422
    end
  end

  private

    def relation_params
      params.require(:relation).permit(:sku_one, :sku_two, :relation_type)
    end
end
