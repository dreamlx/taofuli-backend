class Api::BaseController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session
  before_action :authenticate_user!
  attr_accessor :current_user
  
  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  private
    def authenticate_user!
      openid, options = ActionController::HttpAuthentication::Token.token_and_options(request)
      return unauthenticated! if openid.blank?
      user = User.find_by(openid: openid)
      if user
        self.current_user = user
      else
        self.current_user = User.create!(openid: openid)
      end
    end
    
    def unauthenticated!
      api_error(status: 401)
    end
end