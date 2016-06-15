require 'spec_helper'

describe Api::V1::ProductsController do
  # Within the UsersController's spec, before each test/describe, request the
  # following headers into our HTTP request.
  before(:each) { request.headers['Accept']  = "application/vnd.productcompatibility.v1" }
  # Create a fake Product instance using FactoryGirl and use the get method
  # to return the Product JSON object.
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id, format: :json
    end
    # We expect the JSON response to contain the title of the fake product.
    it "returns the information about the product on a hash" do
      product_response = JSON.parse(response.body, symbolize_names: true)
      expect(product_response[:title]).to eql @product.title
    end
    # If successful, respond with a 200.
    it { should respond_with 200 }
  end

  describe "POST #create" do
    # Create a fake Product instance using FactoryGirl and then use the attributes_for
    # method to set those attributes for the instance.
    context "when is successfully created" do
      before(:each) do
        @product_attributes = FactoryGirl.attributes_for :product
        post :create, { product: @product_attributes }, format: :json
      end
      # Once again, we should expect to find the product's title in the JSON response.
      it "renders the json representation for the product record just created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql @product_attributes[:title]
      end
      # We should expect a 201 response, meaning object successfully created.
      it { should respond_with 201 }
    end
    # In this instance, we create a product without a title, which should be invalid.
    context "when product is not successfully created" do
      before(:each) do
        @invalid_product_attributes = { maker: "Best Buy, Inc.", sku_number: 1234567 }
        post :create, { product: @invalid_product_attributes }, format: :json
      end
      # We expect a JSON response that says we have errors.
      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to have_key(:errors)
      end
      # We expect our JSON response to state that the title can't be blank.
      it "renders the json errors on why the product could not be created" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:errors][:title]).to include "can't be blank"
      end
      # We should expect a 422 response.
      it { should respond_with 422}
    end
  end

  describe "PUT/PATCH #update" do
    # We created fake Product instance using FactoryGirl and then we use
    # the update method to rename the instance.
    context "when is successfully updated" do
      before(:each) do
        @product = FactoryGirl.create :product
        patch :update, { id: @product.id, product: { title: "Xbox One Slim 500GB" } }, format: :json
      end
      # We expect our JSON response to contain the new title of the Product
      # instance which was successfully updated.
      it "renders the json representation for the updated product" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:title]).to eql "Xbox One Slim 500GB"
      end
      # Respond with a 200 message, meaning that everything went well.
      it { should respond_with 200 }
    end
    # In this instance, we create another fake Product instance using FactoryGirl,
    # however, when we try to update the product, we give it a wrong attribute.
    # In this example, we try to pass a string into sku_number which should be an int.
    context "when is not updated" do
      before(:each) do
        @product = FactoryGirl.create :product
        patch :update, { id: @product.id, product: { sku_number: "Hello!" } }, format: :json
      end
      # Expect our JSON response to contain an error message.
      it "renders an errors json" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to have_key(:errors)
      end
      # Expect our JSON response to state that the reason why the update failed
      # was because the sku_number is not a number.
      it "renders the json errors on why the product could not be updated" do
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response[:errors][:sku_number]).to include "is not a number"
      end
      # Expect a 422 response.
      it { should respond_with 422 }
    end
  end
  # Once again, we create a fake Product instance using FactoryGirl and then
  # we find
  describe "DELETE #destroy" do
    before(:each) do
      @product = FactoryGirl.create :product
      delete :destroy, { id: @product.id }, format: :json
    end
    # We should respond with a 204 message, meaning AR object could not be found.
    it { should respond_with 204 }
  end

end
