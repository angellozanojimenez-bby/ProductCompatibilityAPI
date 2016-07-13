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
  # This Relationship is a bit more complicated than your regular create.
  def create
    # In the Relationship model, we take a regular Relationships object and we
    # are going to extract it's contents to create what we need to.
    relationship = Relationships.new(relationship_params)
    # From the params passed, we take the primary node sku and we check if there's
    # already a Product node with that sku.
    if ProductNodes.find_by(sku: relationship.primary_node_sku_or_upc)
      @product_one = ProductNodes.find_by(sku: relationship.primary_node_sku_or_upc)
    else
      # If not found, create a new Product object. Here, we are using FactoryGirl
      # but later on, we are going to get a JSON object from BBY's API.
      @product_one = FactoryGirl.create :product_nodes
    end
    if ProductNodes.find_by(sku: relationship.secondary_node_sku_or_upc)
      @product_two = ProductNodes.find_by(sku: relationship.secondary_node_sku_or_upc)
    else
      @product_two = FactoryGirl.create :product_nodes
    end
    # Create relationship in database.
    relationship = Relationships.create(from_node: @product_one, to_node: @product_two,
    employee_number: relationship.employee_number, notes: relationship.notes,
    primary_node_sku_or_upc: @product_one.sku, secondary_node_sku_or_upc: @product_two.sku)
    # Return the JSON object for the relationship saved.
    if relationship.save
      render json: relationship, status: 201, location: [:api, relationship]
    else
      render json: { errors: relationship.errors }, status: 422
    end
  end
  # In update, we find the Relationship object by its id and we can
  # update some of it's attributes.
  def update
    relationship = Relationships.find(params[:id])
    if relationship.update(relationship_params)
      render json: relationship, status: 200, location: [:api, relationship]
    else
      render json: { errors: relationship.errors }, status: 422
    end
  end
  # Find the Relationship object through its id and destroy the object.
  def destroy
    relationship = Relationships.find(params[:id])
    relationship.destroy
    head 204
  end

  private

    def relationship_params
      params.require(:relationships).permit(:primary_node_sku_or_upc, :secondary_node_sku_or_upc, :employee_number, :notes)
    end
end
