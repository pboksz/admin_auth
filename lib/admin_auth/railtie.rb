module AdminAuth
  class Railtie < ::Rails::Railtie
    initializer :admin_auth do
      ::Admin.include(AdminAuth::Model) if defined?(::Admin)
      ::ApplicationController.include(AdminAuth::Controller) if defined?(::ApplicationController)
    end
  end
end
