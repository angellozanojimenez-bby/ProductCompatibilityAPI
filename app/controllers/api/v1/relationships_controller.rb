class Api::V1::RelationshipsController < ApplicationController
  respond_to :json
  # These methods take care of handling the creation, showing, updating and deletion
  # of the relationships in Neo4j.
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

  end

  def update

  end

  def destroy

  end

  private

    def relationship_params
      params.require(:relationships).permit(:primary_node, :secondary_node, :employee_number, :notes)
    end
end
