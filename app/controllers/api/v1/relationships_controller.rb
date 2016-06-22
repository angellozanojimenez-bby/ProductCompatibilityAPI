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
    relationship = Relationships.new(relationship_params)

    if ProductNodes.find_by(sku: relationship.primary_node_sku)
      @product_one = ProductNodes.find_by(sku: relationship.primary_node_sku)
    else
      @product_one = FactoryGirl.create :product_nodes
    end
    if ProductNodes.find_by(sku: relationship.secondary_node_sku)
      @product_two = ProductNodes.find_by(sku: relationship.secondary_node_sku)
    else
      @product_two = FactoryGirl.create :product_nodes
    end

    relationship_graph = Relationships.create(from_node: @product_one, to_node: @product_two,
    employee_number: relationship.employee_number, notes: relationship.notes,
    primary_node_sku: @product_one.sku, secondary_node_sku: @product_two.sku)
    if relationship.save && relationship_graph.save
      render json: relationship, status: 201, location: [:api, relationship]
    else
      render json: { errors: relationship.errors }, status: 422
    end
  end

  def update

  end

  def destroy

  end

  private

    def relationship_params
      params.require(:relationships).permit(:primary_node_sku, :secondary_node_sku, :employee_number, :notes)
    end
end
