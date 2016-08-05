require File.expand_path('../boot', __FILE__)
# We have switched our application to be a Neo4j application.
require "rails"

%w(
  neo4j
  action_controller
  action_mailer
  sprockets
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

Bundler.require(*Rails.groups)

module Productcompatibilityapi
  class Application < Rails::Application
    config.generators do |g|
      g.orm :neo4j
    end

    config.neo4j.session_options = { basic_auth: { username: 'neo4j', password: 'tamu2016'} }
    config.neo4j.session_type = :server_db
    config.neo4j.session_path = 'http://40.77.61.2:7474'
  end
end
