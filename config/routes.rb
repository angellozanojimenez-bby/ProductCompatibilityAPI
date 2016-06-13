Productcompatibilityapi::Application.routes.draw do
  # We are placing our controllers under an API folder, so we must give The
  # routes a namespace that corresponds to the folder.
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do

  end
end
