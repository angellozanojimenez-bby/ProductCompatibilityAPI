require 'spec_helper'

describe Api::V1::UsersController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do
    # We create a fake user using FactoryGirl and we GET/#show the user
    # by their user id.
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end
    # We expect the response within the JSON body to contain the email
    # which is associated with the user.
    it "returns the information about a user on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end
    # We expect a 200 code response.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # We create a fake user using FactoryGirl and we use the POST/#create
    # method to save the user created with it's attributes.
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end
      # We expect the json response to contain the user's email of the fake
      # user who was just created and to match that email.
      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user_attributes[:email]
      end
      # We should expect a 201 response, meaning successfully object created.
      it { should respond_with 201 }
    end

    context "when user is not successfully created" do
      # In this instance, we create invalid user attributes by leaving the
      # email out blank, so the tests/validations should throw an error.
      before(:each) do
        @invalid_user_attributes = { password: "12345678", password_confirmation: "12345678", employee_number: 1197654 }
        post :create, { user: @invalid_user_attributes }, format: :json
      end
      # We expect our json response to contain errors.
      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
      # We expect our json response to let us know why the method failed,
      # in this instance, because the email can't be blank.
      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end
      # We expect a 422 response.
      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully created" do
      # We create a fake user using FactoryGirl and then through the patch method,
      # we update the email of the user.
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id, user: { email: "newemail@example.com" } }, format: :json
      end
      # We expect the json response to include the new email of the user that
      # was just updated.
      it "renders the json representation for the updated user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql "newemail@example.com"
      end
      # We expect a 200 response to know that we successfully updated the user.
      it { should respond_with 200 }
    end

    context "when is not created" do
      # We create a fake user using FactoryGirl and then through the patch method,
      # we update the email of the user, however it is not a valid email since it
      # does nto contain the @ symbol.
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id, user: { email: "bademail.com" } }, format: :json
      end
      # We expect our json response to contain an error.
      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
      # We expect our json response to contain the reason why the user could
      # not be updated/created, in this instance, it was because the email was
      # invalid.
      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      # We should obtain a 422 response.
      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    # Very simple test, we create a new fake user using FactoryGirl and we then
    # use the delete method to destroy the object.
    before(:each) do
      @user = FactoryGirl.create :user
      delete :destroy, { id: @user.id }, format: :json
    end
    # We expect a 204 response, meaning record not found.
    it { should respond_with 204 }
  end

end
