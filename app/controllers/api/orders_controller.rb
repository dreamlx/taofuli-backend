class Api::OrdersController < Api::BaseController
  def create
    event = Event.find_by(id: params[:event_id])
    return render json: {message: "找不到该福利"} if event.nil?

    order = current_user.orders.build(event_id: event.id)
    order.amount = event.amount
    order.date = Date.today
    order.state = "未派发"
    if order.save
      render json: {}, status: 201
    else
      return api_error(status: 422)
    end
  end

  def index
    @orders = current_user.orders.order(date: :desc)
  end
end