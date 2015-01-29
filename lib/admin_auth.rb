require 'admin_auth/version'
require 'admin_auth/routes'

module AdminAuth
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/**/*.rb"]
  end
end
