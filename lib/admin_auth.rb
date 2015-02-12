require 'admin_auth/controller'
require 'admin_auth/encryptor'
require 'admin_auth/model'
require 'admin_auth/repository'
require 'admin_auth/routes'
require 'admin_auth/version'

module AdminAuth
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/**/*.rb"]
  end

  class Railtie < ::Rails::Railtie
    initializer :admin_auth do
      Admin.include(AdminAuth::Model)
      ApplicationController.include(AdminAuth::Controller)
    end
  end
end
