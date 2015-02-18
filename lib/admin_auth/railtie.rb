module AdminAuth
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ::ApplicationController.include(AdminAuth::Controller) rescue nil
      ::Admin.include(AdminAuth::Model) rescue nil
    end
  end
end
