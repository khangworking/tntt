class Api::V0::GcatholicsController < ApiApplicationController
  def index
    start_date = Date.parse(params[:start])
    end_date = Date.parse(params[:end])
    url = "http://www.gcatholic.org/calendar/#{end_date.year}/VN-vi.htm"
    service = GcatholicService.new(url)
    render json: service.range(start_date, end_date)
  end
end
