class Api::V1::RelationshipsController < ApplicationController
  respond_to :json

  def index
    respond_with Relationships.all
  end

  def show
    respond_with Relationships.find(params[:id])
  end

  # elsewhere
  # rel = ManagedRel.new(from_node: user, to_node: any_node)
  #  if rel.save
  # validation passed, to_node is a manageable object
  # else
  # something is wrong
  # end

  def create
    relationship = Relationships.new(relationship_params)
    if relationship.save
      render json: relationship, status: 201, location: [:api, relationship]
    else
      render json: { errors: relationship.errors }, status: 422
    end
  end

  def update
    relationship = Relationships.find(params[:id])
    if relationship.update(relationship_params)
      render json: relationship, status: 200, location: [:api, relationship]
    else
      render json: { errors: relationship.errors }, status: 422
    end
  end

  def destroy
    relationship = Relationships.find(params[:id])
    relationship.destroy
    head 204
  end

  private

    def relationship_params
      params.require(:relationships).permit(:primary_node, :secondary_node, :employee_number, :notes)
    end
end
