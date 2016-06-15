require 'spec_helper'

describe Api::V1::ProductsController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }

  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id, format: :json
    end

    it "returns the information about the product on a hash" do
      product_response = JSON.parse(response.body, symbolize_names: true)
      expect(product_response[:title]).to eql @product.title
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @product_attributes = FactoryGirl.attributes_for :product
        post :create, { product: @product_attributes }, format: :json
      end

      it "renders the json representation for the product record just created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql @product_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when product is not successfully created" do
      before(:each) do
        @invalid_product_attributes = { maker: "Best Buy, Inc.", sku_number: 1234567 }
        post :create, { product: @invalid_product_attributes }, format: :json
      end

      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422}
    end
  end

  describe "PUT/PATCH #update" do
    context "when is successfully updated" do
      before(:each) do
        @product = FactoryGirl.create :product
        patch :update, { id: @product.id, product: { title: "Xbox One Slim 500GB" } }, format: :json
      end

      it "renders the json representation for the updated product" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql "Xbox One Slim 500GB"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        @product = FactoryGirl.create :product
        patch :update, { id: @product.id, product: { sku_number: "Hello!" } }, format: :json
      end

      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be updated" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:errors][:sku_number]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @product = FactoryGirl.create :product
      delete :destroy, { id: @product.id }, format: :json
    end

    it { should respond_with 204 }
  end

end
