class Admin::BaseController < ApplicationController
  before_action :logged_in_admin

  # layout "admin"

  private
    def logged_in_admin
      unless admin_logged_in?
        flash[:danger] = t(:please_log_in)
        redirect_to admin_login_path
      end
    end
end