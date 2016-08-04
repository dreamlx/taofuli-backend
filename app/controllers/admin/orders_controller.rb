class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.order(updated_at: :desc).page params[:page]
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to admin_orders_url
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_orders_url
    else
      render 'edit'
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to admin_orders_url
  end

  private
    def order_params
      params.require(:order).permit(
        :user_id, :event_id, :amount,
        :state, :date)
    end
end