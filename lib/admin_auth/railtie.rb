module AdminAuth
  class Railtie < ::Rails::Railtie
    initializer :admin_auth do
      ::ApplicationController.include(AdminAuth::Controller) rescue nil
      ::Admin.include(AdminAuth::Model) rescue nil
    end
  end
end
