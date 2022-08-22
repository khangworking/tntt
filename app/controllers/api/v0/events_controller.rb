class Api::V0::EventsController < ApiApplicationController
  # before_action :authenticate_user!

  def index
    start_date = params[:start]
    end_date = params[:end]
    events = Event.where('start_datetime >= :start_date AND start_datetime <= :end_date', start_date: start_date, end_date: end_date).map do |evt|
      {
        title: evt.title,
        start: I18n.l(evt.start_datetime.to_date, format: :default, locale: :en),
        allDay: true
      }
    end
    render json: events
  end
end
