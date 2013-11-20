require "komondor/version"
require "komondor/receiver"
require "komondor/user_concerns"
require "komondor/controller_helpers"
require 'komondor/engine' if ::Rails.version >= '3.1'

if defined?(Rails::Generators::Base)
  require "komondor/generators/install_generator"
end
