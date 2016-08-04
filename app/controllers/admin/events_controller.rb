require 'net/http'
require 'cgi'
class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.order(updated_at: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_url
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to admin_events_url
    else
      render 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to admin_events_url
  end

  def show
    @event = Event.find(params[:id])
  end

  def import
    require 'csv'
    @event = Event.find(params[:id])
    file = params[:file]
    cells = []
    CSV.foreach(file.path, headers: true) do |row|
      # find user according cell
      user = User.find_by(cell: row.to_hash["cell"])
      # find only one order
      order = user.orders.find_by(event_id: params[:id]) if user
      if order
        if order.confirm
          cells << row.to_hash["cell"]
        end
      end 
    end
    redirect_to admin_event_url(@event), notice: "#{cells.to_s}成功导入"
  end

  def pay
    @event = Event.find(params[:id])


    domain = Rails.env.development? ? '139.196.233.121' : '127.0.0.1'
    path = '/wechat/pay.php'
    port = '8080'
    @event.orders.each do |order|
      if order.state == "待派发"
        user = order.user
        parameters = {
          openid: user.openid,
          act_name: @event.title,
          send_name: "淘福利",
          total_amount: order.amount * 100
        }
        res = http_get(domain, path, port, parameters)
        if res.include?("SUCCESS")
          order.pay
        end
      end
    end
    
    redirect_to admin_event_url(@event)
  end

  private
    def event_params
      params.require(:event).permit(
        :title, :url, :image, :amount,
        :effective_date, :expire_date, 
        :state, :quota, :content, 
        :official_benefit, :additional_benefit)
    end

    def http_get(domain,path, port, params)
        return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')), port ) if not params.nil?
        return Net::HTTP.get(domain, path)
    end
end