require 'spec_helper'

describe Api::V1::RelationshipsController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do
    # A bit different from the rest of our tests, we use FactoryGirl to create
    # to product nodes. We then use some of those attributes to fill in the
    # Relationships' attributes.
    before(:each) do
      @product_node_one = FactoryGirl.create :product_nodes
      @product_node_two = FactoryGirl.create :product_nodes
      @relationship = Relationships.create(from_node: @product_node_one, to_node: @product_node_two,
      employee_number: 1197566, primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
      notes: "These two products work amazing together!")
      get :show, id: @relationship.id, format: :json
    end
    # We expect our JSON response to contain the primary node sku which was
    # just created.
    it "returns the information of a relationship on a hash" do
      relationship_response = json_response
      expect(relationship_response[:relationships][:primary_node_sku_or_upc]).to eql @product_node_one.sku
    end
    # We expect a 201 response meaning that everything went well and the Relationship was created.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # In this context, we are going to test that a relationship can be created if
    # given the right amount and type of attributes.
    context "when is successfully created" do
      # Once again, we create two product nodes using FactoryGirl and set the relationship
      # attributes in a hash to fulfill the Relationships object.
      before(:each) do
        @product_node_one = FactoryGirl.create :product_nodes
        @product_node_two = FactoryGirl.create :product_nodes
        @relationship_attributes = { from_node: @product_node_one, to_node: @product_node_two,
        employee_number: 1197566, primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
        notes: "These two products work amazing together!"}
        post :create, { relationships: @relationship_attributes }, format: :json
      end
      # We expect our JSON response to contain the primary node sku which was
      # just created.
      it "renders the json representation for the relationship just created" do
        relationship_response = json_response
        expect(relationship_response[:relationships][:primary_node_sku_or_upc]).to eql @product_node_one.sku
      end
      # We expect a 201 response meaning that everything went well and the Relationship was created.
      it { should respond_with 201 }
    end
    # In this context, we will check that a relationship cannot be created with
    # invalid attributes.
    context "when is not successfully created" do
      # In this attempt, we did not set an employee number to the relationship.
      before(:each) do
        @product_node_one = FactoryGirl.create :product_nodes
        @product_node_two = FactoryGirl.create :product_nodes
        @invalid_relationship_attributes = { from_node: @product_node_one, to_node: @product_node_two,
        primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
        notes: "These two products work amazing together!"}
        post :create, { relationships: @invalid_relationship_attributes }, format: :json
      end
      # We expect our JSON response to catch that we have errors.
      it "renders an errors json" do
        relationship_response = json_response
        expect(relationship_response).to have_key(:errors)
      end
      # We expect our JSON response to recognize that the error is that the employee
      # number attribute cannot be blank in order to create a new relationship.
      it "renders the json errors on why the relationship could not be created" do
        relationship_response = json_response
        expect(relationship_response[:errors][:employee_number]).to include "can't be blank"
      end
      # We expect a 422 response, meaning that something went wrong.
      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    # In this context, we will test that we can successfully update a relationship.
    context "when is successfully updated" do
      # We create a fake relationship using FactoryGirl by creating two product nodes
      # and setting their right attribuets. We then take the employee_number and we
      # update it to another integer value.
      before(:each) do
        @product_node_one = FactoryGirl.create :product_nodes
        @product_node_two = FactoryGirl.create :product_nodes
        @relationship = Relationships.create(from_node: @product_node_one, to_node: @product_node_two,
        employee_number: 1197566, primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
        notes: "These two products work amazing together!")
        patch :update, { id: @relationship.id, relationships: { employee_number: 11991199 } }, format: :json
      end
      # We expect our JSON response to include our newly updated employee number.
      it "renders the json representation for the updated relationship" do
        relationship_response = json_response
        expect(relationship_response[:relationships][:employee_number]).to eql 11991199
      end
      # We expect a 200 response, meaning that everything went well.
      it { should respond_with 200 }
    end
    # In this context, we will test that a relationship cannot be updated if given
    # an invalid attribute. We try to update the employee number to nil.
    context "when is not successfully updated" do
      before(:each) do
        @product_node_one = FactoryGirl.create :product_nodes
        @product_node_two = FactoryGirl.create :product_nodes
        @relationship = Relationships.create(from_node: @product_node_one, to_node: @product_node_two,
        employee_number: 1197566, primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
        notes: "These two products work amazing together!")
        patch :update, { id: @relationship.id, relationships: { employee_number: nil } }, format: :json
      end
      # We expect our JSON response to catch that we have errors.
      it "renders an errors json" do
        relationship_response = json_response
        expect(relationship_response).to have_key(:errors)
      end
      # We expect our JSON response to recognize that our errors are coming from the
      # employee number being nil or blank.
      it "renders the json errors on why the relationship could not be updated" do
        relationship_response = json_response
        expect(relationship_response[:errors][:employee_number]).to include "can't be blank"
      end
      # We expect a 422 response, meaning something went wrong.
      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    # Very simple example in this instance, we create a fake relationship through
    # FactoryGirl and creating the two products and then we check that we are
    # able to delete such node using the destroy call on the relationship.
    before(:each) do
      @product_node_one = FactoryGirl.create :product_nodes
      @product_node_two = FactoryGirl.create :product_nodes
      @relationship = Relationships.create(from_node: @product_node_one, to_node: @product_node_two,
      employee_number: 1197566, primary_node_sku_or_upc: @product_node_one.sku, secondary_node_sku_or_upc: @product_node_two.sku,
      notes: "These two products work amazing together!")
      delete :destroy, { id: @relationship.id }, format: :json
    end
    # We expect a 204 response, meaning that the node cannot be found.
    it { should respond_with 204 }
  end

end
