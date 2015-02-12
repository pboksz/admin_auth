module AdminAuth
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/app/**/*.rb"]
    config.autoload_paths += Dir["#{config.root}/app/**/*.haml"]
  end
end
