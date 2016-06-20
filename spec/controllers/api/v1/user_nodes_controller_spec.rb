require 'spec_helper'

describe Api::V1::UserNodesController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do

    before(:each) do
      @user_node = FactoryGirl.create :user_nodes
      get :show, id: @user_node.id, format: :json
    end

     it "returns the information of a user on a hash" do
       user_node_response = JSON.parse(response.body, symbolize_names: true)
       expect(user_node_response[:user_nodes][:email]).to eql @user_node.email
     end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do

      before(:each) do
        @user_node_attributes = FactoryGirl.attributes_for :user_nodes
        post :create, { user_nodes: @user_node_attributes }, format: :json
      end

      it "renders the json representation for the user node record just created" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response[:user_nodes][:email]).to eql @user_node_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not successfully created" do

      before(:each) do
        @invalid_user_node_attributes = { password: "renewblue123", password_confirmation: "renewblue123",
        employee_number: 1234567, employee_score: 0 }
        post :create, { user_nodes: @invalid_user_node_attributes }, format: :json
      end

      it "renders an errors json" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be created" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do

      before(:each) do
          @user_node = FactoryGirl.create :user_nodes
          patch :update, { id: @user_node.id, user_nodes: { email: "mynewemail@bestbuy.com" } }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response[:user_nodes][:email]).to eql "mynewemail@bestbuy.com"
      end

      it { should respond_with 200 }
    end

    context "when is not successfully updated" do

      before(:each) do
        @user_node = FactoryGirl.create :user_nodes
        patch :update, { id: @user_node.id, user_nodes: { email: "" } }, format: :json
      end

      it "renders an errors json" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be updated" do
        user_node_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_node_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      @user_node = FactoryGirl.create :user_nodes
      delete :destroy, { id: @user_node.id }, format: :json
    end

    it { should respond_with 204 }
  end

end
