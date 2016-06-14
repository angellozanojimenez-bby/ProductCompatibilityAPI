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
    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end
    # We expect a 200 code response.
    it { should respond_with 200 }
  end

end
