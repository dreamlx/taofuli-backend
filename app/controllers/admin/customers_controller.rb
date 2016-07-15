class Admin::CustomersController < Admin::BaseController
  def index
    @customers = Customer.order(updated_at: :desc)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to admin_customers_url
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(params.require(:customer).permit(:state, :note))
      redirect_to admin_customers_url
    else
      render 'edit'
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    redirect_to admin_customers_url
  end

  private
    def customer_params
      params.require(:customer).permit(
        :name, :cell, :qq, :desc,
        :state, :note)
    end
end