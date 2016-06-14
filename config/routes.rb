require 'api_constraints'

Productcompatibilityapi::Application.routes.draw do
  devise_for :relations
  devise_for :products
  devise_for :users
  # We are placing our controllers under an API folder, so we must give The
  # routes a namespace that corresponds to the folder.
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    # We version our API so it is easier to expand and develop a more complicated
    # API in the future. 'scope module v1' refers to the version and directory of our current API version.
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # This scope will contain all of our model resources.
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :products, :only => [:show]
      resources :relations, :only => [:show]
    end
  end
end
