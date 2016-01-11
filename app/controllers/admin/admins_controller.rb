class Admin::AdminsController < Admin::BaseController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_admins_url
    else
      render 'new'
    end
  end

  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to admin_admins_url
    else
      render 'edit'
    end
  end

  def destroy
    Admin.find(params[:id]).destroy
    redirect_to admin_admins_url
  end

  private
    def admin_params
      params.require(:admin).permit(:name, :password, :password_confirmation)
    end
end