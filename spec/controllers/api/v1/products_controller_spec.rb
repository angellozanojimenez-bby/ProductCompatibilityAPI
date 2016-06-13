require 'spec_helper'

describe Api::V1::ProductsController do
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }
end
