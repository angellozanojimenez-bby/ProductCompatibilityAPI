require 'api_constraints'

Productcompatibilityapi::Application.routes.draw do
  # We are placing our controllers under an API folder, so we must give The
  # routes a namespace that corresponds to the folder.
  # This scope will contain all of our model resources.
  # Resources used in Neo4j.
  resources :user_nodes, :only => [:index, :show, :create, :update, :destroy], :defaults => { :format => 'json' }
  resources :relationships, :only => [:index, :show, :create, :update, :destroy], :defaults => { :format => 'json' }
  resources :product_nodes, :only => [:index, :show, :create, :update, :destroy], :defaults => { :format => 'json' }
  resources :incompatible_relationships, :only => [:index, :show, :create, :update, :destroy], :defaults => { :format => 'json' }
  # These are the routes that redirect to single product lookup through SKUs.
  get '/compatible_product_relationships/:primary_node_sku', to: 'relationships#show_by_product', :defaults => { :format => 'json' }
  get '/incompatible_product_relationships/:primary_node_sku', to: 'incompatible_relationships#show_by_product', :defaults => { :format => 'json' }
  get '/users', to: 'user_nodes#show_by_email', :defaults => { :format => 'json' }
end
