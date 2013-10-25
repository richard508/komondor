class SessionsController < ApplicationController
  def new
    receiver = SingleSignOn::Receiver.new(params[:sig])
    unless receiver.valid?
      redirect_to "#{ENV['SSO_URL']}/signin?referrer=#{request.host}"
      return
    end
<% if rails4? -%>
    user = User.find_by(identity_id: receiver.parsed_message[0])
<% else -%>
    user = User.find_by_identity_id(receiver.parsed_message[0])
<% end -%>
    sign_in user if user
    redirect_to root_path
  end

  def destroy
    sign_out
    # redirect_to root_path
    redirect_to "#{ENV['SSO_URL']}/?signout=true&referrer=#{request.host}"
  end

  def signout
    receiver = SingleSignOn::Receiver.new(params[:sig])
    if receiver.valid?
<% if rails4? -%>
      user = User.find_by(identity_id: receiver.parsed_message[0])
<% else -%>
      user = User.find_by_identity_id(receiver.parsed_message[0])
<% end -%>
      user.create_remember_token
      user.save
    end
    render nothing: true
  end
end
