class Api::EventsController < Api::BaseController
  def index
    @q = Event.ransack(state_eq: "有效", effective_date_lteq: Date.today, expire_date_gteq: Date.today)
    @events = @q.result.order(updated_at: :desc)
  end
end