require "single_sign_on/version"
require "single_sign_on/receiver"
require "single_sign_on/user_concerns"
require "single_sign_on/controller_helpers"
require 'single_sign_on/engine' if ::Rails.version >= '3.1'

if defined?(Rails::Generators::Base)
  require "single_sign_on/generators/install_generator"
end
