require 'active_support/concern'

module Komondor
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :current_user, :signed_in?
    end

    def sign_in(user)
      remember_token = User.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.encrypt(remember_token))
      self.current_user = user
    end

    def sign_out
      self.current_user = OpenStruct.new(identity_id: -1)
      cookies.delete(:remember_token)
    end

    def signed_in?
      current_user.identity_id != -1
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      remember_token  = User.encrypt(cookies[:remember_token])
      if ::Rails.version >= '4.0'
        @current_user ||= User.find_by(remember_token: remember_token) || OpenStruct.new(identity_id: -1)
      else
        @current_user ||= User.find_by_remember_token(remember_token) || OpenStruct.new(identity_id: -1)
      end
    end

    def guard_dog
      unless signed_in?
        redirect_to new_sessions_path
      end
    end
  end
end
