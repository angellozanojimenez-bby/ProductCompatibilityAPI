require 'httparty'

class Api::V1::CompatibleProductRelationshipsController < ApplicationController
  respond_to :json
  # These methods take care of handling the creation, showing, updating and deletion
  # of the relationships in Neo4j.

  def index
    respond_with Relationships.all
  end

  def show
    respond_with Relationships.where(primary_node_sku_or_upc: params[:primary_node_sku_or_upc].to_i)
  end

end
