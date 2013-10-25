class UsersController < ApplicationController
  def new
    if params[:sig]
      receiver = SingleSignOn::Receiver.new(params[:sig])
      unless receiver.valid?
        render nothing: true, status: :bad_request
        return
      end
      user_params = receiver.parsed_message.select { |k,v| [:name, :email, :identity_id].include?(k) }
      user = User.new(user_params)
      if user.save
        render nothing: true, status: :created
      else
        render nothing: true, status: :bad_request
      end
    end
  end
end
