require 'httparty'
# Relationships are Compatible Relationships.
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

  def show_by_product
    respond_with Relationships.where(primary_node_sku: params[:primary_node_sku].to_i)
  end
  # This Relationship is a bit more complicated than your regular create.
  def create
    # In the Relationship model, we take a regular Relationships object and we
    # are going to extract it's contents to create what we need to.
    relationship = Relationships.new(relationship_params)
    # From the params passed, we take the primary node sku and we check if there's
    # already a Product node with that sku.
    if ProductNodes.find_by(sku: relationship.primary_node_sku)
      @product_one = ProductNodes.find_by(sku: relationship.primary_node_sku)
    else
      # If not found, create a new Product object. Here, we are using FactoryGirl
      # but later on, we are going to get a JSON object from BBY's API.
      first_product_lookup = bbyApiLookup(relationship.primary_node_sku)
      @product_one = ProductNodes.create(title: first_product_lookup["name"], maker: first_product_lookup["manufacturer"], sku: first_product_lookup["sku"], price: first_product_lookup["salePrice"])
    end

    if ProductNodes.find_by(sku: relationship.secondary_node_sku)
      @product_two = ProductNodes.find_by(sku: relationship.secondary_node_sku)
    else
      second_product_lookup = bbyApiLookup(relationship.secondary_node_sku)
      @product_two = ProductNodes.create(title: second_product_lookup["name"], maker: second_product_lookup["manufacturer"], sku: second_product_lookup["sku"], price: second_product_lookup["salePrice"])
    end
    # Create relationship in database.
    relationship = Relationships.create(from_node: @product_one, to_node: @product_two,
    employee_number: relationship.employee_number, notes: relationship.notes,
    primary_node_sku: @product_one.sku, secondary_node_sku: @product_two.sku)
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

  def bbyApiLookup(sku_or_upc)
    if sku_or_upc.to_s.length < 10
      api_url = "https://api.bestbuy.com/v1/products(sku='#{sku_or_upc}')?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=name.asc&show=name,manufacturer,sku,salePrice&format=json"
      response = HTTParty.get(api_url)
      return response.parsed_response["products"].first
    else
      api_url = "https://api.bestbuy.com/v1/products(upc='#{sku_or_upc}')?apiKey=3nmxuf48rjc2jhxz7cwebcze&sort=name.asc&show=name,manufacturer,sku,salePrice&format=json"
      response = HTTParty.get(api_url)
      return response.parsed_response["products"].first
    end
  end

  private

    def relationship_params
      params.require(:relationships).permit(:primary_node_sku, :secondary_node_sku, :employee_number, :notes)
    end
end
