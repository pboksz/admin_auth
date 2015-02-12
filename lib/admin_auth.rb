require 'admin_auth/version'

if defined?(Rails)
  require 'admin_auth/controller'
  require 'admin_auth/encryptor'
  require 'admin_auth/model'
  require 'admin_auth/repository'
  require 'admin_auth/routes'

  require 'admin_auth/engine'
  require 'admin_auth/railtie'
end

module AdminAuth

end
