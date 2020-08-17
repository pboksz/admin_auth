# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'admin_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "admin_auth"
  spec.version       = AdminAuth::VERSION
  spec.authors       = ["Phillip Boksz"]
  spec.email         = ["pboksz@gmail.com"]
  spec.summary       = "A gem for rails that helps with basic database authentication."
  spec.description   = spec.summary
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/pboksz/admin_auth"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "bcrypt", ">= 3.0.0"
  spec.add_dependency "haml", ">= 4.0.0"

  spec.add_development_dependency "rails", ">= 4.0.0"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
