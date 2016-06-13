class Api::V1::RelationsController < ApplicationController
  respond_to :json

  def show
    respond_with Relation.find(params[:id])
  end
end
