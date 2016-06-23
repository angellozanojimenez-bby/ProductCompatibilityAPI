require 'spec_helper'

describe Api::V1::UserNodesController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }
  # In this block, we are going to test the get http method through the id of an object.
  describe "GET #show" do
    # We use FactoryGirl to create a fake user node, we use the get method
    # through the id of the user node.
    before(:each) do
      @user_node = FactoryGirl.create :user_nodes
      get :show, id: @user_node.id, format: :json
    end
    # We expect our JSON response to contain the email of the user node which
    # was just created.
    it "returns the information of a user on a hash" do
      user_node_response = json_response
      expect(user_node_response[:user_nodes][:email]).to eql @user_node.email
    end
    # We expect a 200 response, meaning that everything was successful.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # In this context, we are going to test the ability to post to the database,
    # meaning that we will try to create a new object through given attributes.
    context "when is successfully created" do
      # We use FactoryGirl to create a fake user node and we give it the attributes
      # also created by FactoryGirl.
      before(:each) do
        @user_node_attributes = FactoryGirl.attributes_for :user_nodes
        post :create, { user_nodes: @user_node_attributes }, format: :json
      end
      # We expect our JSON response to contain the same email that was created
      # by FactoryGirl and we check to see if they match.
      it "renders the json representation for the user node record just created" do
        user_node_response = json_response
        expect(user_node_response[:user_nodes][:email]).to eql @user_node_attributes[:email]
      end
      # In this instance, we expect a 201 response meaning that the object was successfully
      # created and saved.
      it { should respond_with 201 }
    end
    # In this context, we are going to test that a user node should not be created
    # whenever there are insufficient or invalid attributes given to the user node.
    context "when is not successfully created" do
      # As you can see, within the invalid user node attributes, we have not given the
      # user node an email address, which must be validated present in the model.
      before(:each) do
        @invalid_user_node_attributes = { password: "renewblue123", password_confirmation: "renewblue123",
        employee_number: 1234567, employee_score: 0 }
        post :create, { user_nodes: @invalid_user_node_attributes }, format: :json
      end
      # We expect our JSON response to state that we have errors.
      it "renders an errors json" do
        user_node_response = json_response
        expect(user_node_response).to have_key(:errors)
      end
      # We expect our JSON response to state that the error was that the email
      # address for the user node cannot be blank.
      it "renders the json errors on why the user node could not be created" do
        user_node_response = json_response
        expect(user_node_response[:errors][:email]).to include "can't be blank"
      end
      # We expect our JSON to contain a 422 response which means that something went wrong.
      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    # In this context, we are going to test that a user node can be successfully updated,
    # if given the right type and amount of attributes.
    context "when is successfully updated" do
      # Once again, we create a fake user node using FactoryGirl, we then use the update
      # method by using the node's id and we pass the arguments into a JSON.
      before(:each) do
          @user_node = FactoryGirl.create :user_nodes
          patch :update, { id: @user_node.id, user_nodes: { email: "mynewemail@bestbuy.com" } }, format: :json
      end
      # In this instance, we expect that our update was successful and that our JSON
      # response will contain the new email of the user node.
      it "renders the json representation for the updated user" do
        user_node_response = json_response
        expect(user_node_response[:user_nodes][:email]).to eql "mynewemail@bestbuy.com"
      end
      # We should respond with a 200 that everything went okay.
      it { should respond_with 200 }
    end
    # In this context, we will test that given the invalid or wrong number of attributes,
    # that a user node cannot be updated.
    context "when is not successfully updated" do
      # We create a fake user node using FactoryGirl, however, when we call an update
      # method for the user node, we give a blank email.
      before(:each) do
        @user_node = FactoryGirl.create :user_nodes
        patch :update, { id: @user_node.id, user_nodes: { email: "" } }, format: :json
      end
      # We expect our JSON response to say that there has been an error with the email.
      it "renders an errors json" do
        user_node_response = json_response
        expect(user_node_response).to have_key(:errors)
      end
      # We expect the JSON response to contain that the error was that the email
      # cannot be blank for the given email attribute.
      it "renders the json errors on why the user could not be updated" do
        user_node_response = json_response
        expect(user_node_response[:errors][:email]).to include "can't be blank"
      end
      # We expect a 422 response.
      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    # Very simple example in this instance, we create a fake user node through
    # FactoryGirl and then we check that we are able to delete such node using the
    # destroy call on the node.
    before(:each) do
      @user_node = FactoryGirl.create :user_nodes
      delete :destroy, { id: @user_node.id }, format: :json
    end
    # We expect a 204 response, meaning that the node cannot be found.
    it { should respond_with 204 }
  end

end
