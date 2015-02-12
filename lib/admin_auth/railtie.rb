module AdminAuth
  class Railtie < ::Rails::Railtie
    initializer :admin_auth do
      ::Admin.include(AdminAuth::Model)
      ::ApplicationController.include(AdminAuth::Controller)
    end
  end
end
