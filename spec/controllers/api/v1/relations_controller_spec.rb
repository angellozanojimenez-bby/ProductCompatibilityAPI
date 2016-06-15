require 'spec_helper'

describe Api::V1::RelationsController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }
  # We create a fake Relation instance using Factory girl and we use the get
  # method to return the relation by its id attribute.
  describe "GET #show" do
    before(:each) do
      @relation = FactoryGirl.create :relation
      get :show, id: @relation.id, format: :json
    end
    # We expect our relation response JSON to include the value of sku_one
    # and we expect it to match to the sku_one value in the Relation instance.
    it "returns the information about the relation on a hash" do
      relation_response = JSON.parse(response.body, symbolize_names: true)
      expect(relation_response[:sku_one]).to eql @relation.sku_one
    end
    # Expect a 200 response, meaning everything went okay.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # We create a fake Relation instance using FactoryGirl and we give it attributes
    # also genereted by FactoryGirl.
    context "when is successfully created" do
      before(:each) do
        @relation_attributes = FactoryGirl.attributes_for :relation
        post :create, { relation: @relation_attributes }, format: :json
      end
      # We expect that the sku_one attribute given by FactoryGirl matches the
      # sku_one value that comes as a response in our JSON hash.
      it "renders the json representation for the relation record just created" do
        relation_response = JSON.parse(response.body, symbolize_names: true)
        expect(relation_response[:sku_one]).to eql @relation_attributes[:sku_one]
      end
      # We expect a 201 value meaning that the object was successfully created.
      it { should respond_with 201 }
    end
    # We create a Relation instance, however, we give it a series of invalid
    # attributes, in this instance, sku_two which is supposed to be a number
    # is given a string value.
    context "when relation is not successfully created" do
      before(:each) do
        @invalid_relation_attributes = { sku_one: 1197564, sku_two: "Hello", relation_type: "works_with"}
        post :create, { relation: @invalid_relation_attributes }, format: :json
      end
      # We expect our JSON response to state that there was an error.
      it "renders an errors json" do
        relation_response = JSON.parse(response.body, symbolize_names: true)
        expect(relation_response).to have_key(:errors)
      end
      # We expect the JSON response to identify that the error was that sku_two
      # was not given a number value when initiated.
      it "renders the json errors on why the product could not be created" do
        relation_response = JSON.parse(response.body, symbolize_names: true)
        expect(relation_response[:errors][:sku_two]).to include "is not a number"
      end
      # We expect a 422 response.
      it { should respond_with 422 }
    end
  end

end
