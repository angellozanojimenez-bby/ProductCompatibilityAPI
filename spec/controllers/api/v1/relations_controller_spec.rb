require 'spec_helper'

describe Api::V1::RelationsController do
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }
end
