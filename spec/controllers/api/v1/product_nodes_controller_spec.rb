require 'spec_helper'

describe Api::V1::ProductNodesController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do
    # We use FactoryGirl to create a fake product node and we use the get
    # method call to retrieve the JSON hash of the product node.
    before(:each) do
      @product_node = FactoryGirl.create :product_nodes
      get :show, id: @product_node.id, format: :json
    end
    # We expect our JSON response to contain the title of the product node
    # which was just created.
    it "returns the information of a product on a hash" do
      product_node_response = json_response
      expect(product_node_response[:product_nodes][:title]).to eql @product_node.title
    end
    # We expect a 200 response, meaning that everything was successful.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # In this context, we are going to test that a product node can be created
    # if given the right amount and type of attributes.
    context "when is successfully created" do
      # We create some fake product node attributes using FactoryGirl. We then use the
      # post method to pass these attributes and try to create a new product node.
      before(:each) do
        @product_node_attributes = FactoryGirl.attributes_for :product_nodes
        post :create, { product_nodes: @product_node_attributes }, format: :json
      end
      # We expect our JSON response to contain the title of the product node
      # just created.
      it "renders the json representation for the product node just created" do
        product_node_response = json_response
        expect(product_node_response[:product_nodes][:title]).to eql @product_node_attributes[:title]
      end
      # We expect a 201 response meaning that everything went well and the node was
      # successfully created.
      it { should respond_with 201 }
    end
    # In this context, we will check that a product node cannot be created with
    # invalid attributes.
    context "when is not successfully created" do
      # Here, we attempt to create a new product node without a title attirbute.
      before(:each) do
        @invalid_product_node_attributes = { maker: "Best Buy, Inc.", sku: 1122334, price: 199.99 }
        post :create, { product_nodes: @invalid_product_node_attributes }, format: :json
      end
      # We expect our JSON response to catch that we have errors.
      it "renders an errors json" do
        product_node_response = json_response
        expect(product_node_response).to have_key(:errors)
      end
      # We expect our JSON response to recognize that the error is that the title
      # attribute cannot be blank in order to create a new product node.
      it "renders the json errors on why the product node could not be created" do
        product_node_response = json_response
        expect(product_node_response[:errors][:title]).to include "can't be blank"
      end
      # We expect a 422 response, meaning that something went wrong.
      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    # In this context, we will test that we can successfully update a product node.
    context "when is successfully updated" do
      # We create a fake product node using FactoryGirl and then by calling the update
      # method, we update the title of the recently created node.
      before(:each) do
        @product_node = FactoryGirl.create :product_nodes
        patch :update, { id: @product_node.id, product_nodes: { title: "The newest and biggest TV!" } }, format: :json
      end
      # We expect the JSON response to contain the new title of the product node.
      it "renders the json representation for the updated product" do
        product_node_response = json_response
        expect(product_node_response[:product_nodes][:title]).to eql "The newest and biggest TV!"
      end
      # We expect a 200 response, meaning that everything went okay.
      it { should respond_with 200 }
    end
    # In this context, we will test that a product node cannot be updated if it is
    # given an invalid attribute.
    context "when is not successfully updated" do
      # We create a fake product node using FactoryGirl, however, as you can see,
      # the new title that is trying to be updated on the product node is blank.
      before(:each) do
        @product_node = FactoryGirl.create :product_nodes
        patch :update, { id: @product_node.id, product_nodes: { title: "" } }, format: :json
      end
      # We expect our JSON to state that we have errors.
      it "renders an errors json" do
        product_node_response = json_response
        expect(product_node_response).to have_key(:errors)
      end
      # We expect our JSON response to recognize that the error that was made was
      # tha the title for the product node cannot be blank.
      it "renders the json errors on why the product could not be updated" do
        product_node_response = json_response
        expect(product_node_response[:errors][:title]).to include "can't be blank"
      end
      # We expect a 422 response, meaning that something went wrong.
      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    # Very simple example in this instance, we create a fake product node through
    # FactoryGirl and then we check that we are able to delete such node using the
    # destroy call on the node.
    before(:each) do
      @product_node = FactoryGirl.create :product_nodes
      delete :destroy, { id: @product_node.id }, format: :json
    end
    # We expect a 204 response, meaning that the node cannot be found.
    it { should respond_with 204 }
  end

end
