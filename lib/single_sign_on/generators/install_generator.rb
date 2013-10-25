require 'rails/generators/active_record'

module SingleSignOn
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def add_routes
        route "resources :users, only: [:new]"
        route "resource :sessions, only: [:new, :destroy] { get 'signout', on: :member }"
      end

      def add_helper_module_to_application_controller
        inject_into_class "app/controllers/application_controller.rb", ApplicationController, "  include SingleSignOn::ControllerHelpers\n"
      end

      def copy_controllers
        template 'sessions_controller.rb', 'app/controllers/sessions_controller.rb'
        template 'users_controller.rb', 'app/controllers/users_controller.rb'
      end

      def create_topbar
        template 'single_sign_on.css.scss', 'app/assets/stylesheets/single_sign_on.css.scss'
        inject_into_file 'app/assets/javascripts/application.js', before: "//= require_tree ." do
          "//= require single_sign_on\n"
        end
      end

      def add_model
        generate 'model', 'user email identity_id:index'
        inject_into_class "app/models/user.rb", User, "  include SingleSignOn::UserConcerns\n"
      end
    end
  end
end
