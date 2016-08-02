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

  private
    def event_params
      params.require(:event).permit(
        :title, :url, :image, :amount,
        :effective_date, :expire_date, 
        :state, :quota, :content, 
        :official_benefit, :additional_benefit)
    end
end