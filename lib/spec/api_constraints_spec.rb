require 'spec_helper'

describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2, default: true) }

  describe "matches?" do
    # We check for a version 1 match for our API within the
    # HTTP 'Accept' header.
    it "returns true when the version matches the 'Accept' header" do
      request = double(host: 'api.productcompatibilityapi.dev',
                       headers: {"Accept" => "application/vnd.productcompatibility.v1"})
      api_constraints_v1.matches?(request).should be_true
    end
    # If the version 1 key value is not found in the header, default to the
    # specified API version.
    it "returns the default version when 'default' option is specified" do
      request = double(host: 'api.productcompatibilityapi.dev')
      api_constraints_v2.matches?(request).should be_true
    end
  end
end
