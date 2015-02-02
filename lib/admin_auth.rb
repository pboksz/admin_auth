require 'admin_auth/encryptor'
require 'admin_auth/models'
require 'admin_auth/routes'
require 'admin_auth/version'

module AdminAuth
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/**/*.rb"]
  end
end
