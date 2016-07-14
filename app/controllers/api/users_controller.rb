class Api::UsersController < Api::BaseController
  def update_profile
    @user = current_user
    if @user.update(user_params)
      render 'get_info'
    else
      return api_error(status: 422)
    end
  end

  def get_info
    @user = current_user
  end

  private
    def user_params
      params.permit(:name, :gender, :cell, :email)
    end
end