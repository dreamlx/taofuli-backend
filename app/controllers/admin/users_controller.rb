class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(updated_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.openid = params[:user][:openid]
    if @user.save
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url
    else
      render 'edit'
    end
  end

  def active
    user = User.find(params[:id])
    user.active
    redirect_to admin_users_url
  end

  def inactive
    user = User.find(params[:id])
    user.inactive
    redirect_to admin_users_url
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_url
  end
  private
    def user_params
      params.require(:user).permit(
        :name, :gender, :cell, :email)
    end
end