require 'rails/generators/active_record'

module Komondor
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def add_routes
        route "resources :users, only: [:new]"
        route "resource :sessions, only: [:new, :destroy] { get 'signout', on: :member }"
        route "get '/signin' => 'sessions#new'"
      end

      def add_helper_module_to_application_controller
        inject_into_class "app/controllers/application_controller.rb", ApplicationController, "  include Komondor::ControllerHelpers\n"
      end

      def copy_controllers
        template 'sessions_controller.rb', 'app/controllers/sessions_controller.rb'
        template 'users_controller.rb', 'app/controllers/users_controller.rb'
      end

      def create_topbar
        template 'komondor.css.scss', 'app/assets/stylesheets/komondor.css.scss'
        template 'komondor.js.coffee.erb', 'app/assets/javascripts/komondor.js.coffee.erb'
        inject_into_file 'app/assets/javascripts/application.js', before: "//= require_tree ." do
          "//= require komondor\n"
        end
        inject_into_file "app/views/layouts/application.html.erb", before: "</head>" do
          "  <script>Komondor = { identity_id: <%= current_user.identity_id %>, url: '<%= ENV['SSO_URL'] %>', name: '<%= ENV['SSO_NAME'] %>' };</script>\n"
        end
      end

      def add_model
        generate 'model', 'user name email identity_id:index remember_token:index'
        inject_into_class "app/models/user.rb", User, "  include Komondor::UserConcerns\n"
      end

      private

      def rails4?
        Rails::VERSION::MAJOR == 4
      end
    end
  end
end
