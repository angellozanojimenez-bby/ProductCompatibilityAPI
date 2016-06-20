require 'spec_helper'

describe Api::V1::RelationshipsController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do

  end

  describe "POST #create" do

  end

  describe "PUT/PATCH #update" do

  end

  describe "DELETE #destroy" do

  end

end
