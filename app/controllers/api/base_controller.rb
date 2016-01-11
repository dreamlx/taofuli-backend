class Api::BaseController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session
  attr_accessor :current_user
  
  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  private
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    name = options.blank?? nil : options[:name]
    user = name && User.find_by(name: name)
    
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      self.current_user = user
    else
      return unauthenticated!
    end
  end
    
    def unauthenticated!
      api_error(status: 401)
    end
end