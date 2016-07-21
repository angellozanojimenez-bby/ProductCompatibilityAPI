require 'api_constraints'

Productcompatibilityapi::Application.routes.draw do
  # We are placing our controllers under an API folder, so we must give The
  # routes a namespace that corresponds to the folder.
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    # We version our API so it is easier to expand and develop a more complicated
    # API in the future. 'scope module v1' refers to the version and directory of our current API version.
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # This scope will contain all of our model resources.
      get '/compatible_product_relationships/:primary_node_sku_or_upc', to: 'compatible_product_relationships#show'
      get '/incompatible_product_relationships/:primary_node_sku_or_upc', to: 'incompatible_product_relationships#show'
      resources :users, :only => [:index, :show, :create, :update, :destroy]
      resources :products, :only => [:index, :show, :create, :update, :destroy]
      resources :relations, :only => [:index, :show, :create]
      # Resources used in Neo4j.
      resources :user_nodes, :only => [:index, :show, :create, :update, :destroy]
      resources :relationships, :only => [:index, :show, :create, :update, :destroy]
      resources :compatible_product_relationships, :only => [:index]
      resources :incompatible_product_relationships, :only => [:index]
      resources :product_nodes, :only => [:index, :show, :create, :update, :destroy]
      resources :incompatible_relationships, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end
