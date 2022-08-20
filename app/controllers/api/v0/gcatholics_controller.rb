class Api::V0::GcatholicsController < ApiApplicationController
  def index
    start_date = Date.parse(params[:start])
    end_date = Date.parse(params[:end])
    if start_date.year == end_date.year
      url = "http://www.gcatholic.org/calendar/#{end_date.year}/VN-vi.htm"
      service = GcatholicService.new(url)
      render json: service.range(start_date, end_date)
    else
      url = "http://www.gcatholic.org/calendar/#{start_date.year}/VN-vi.htm"
      service = GcatholicService.new(url)
      results1 = service.range(start_date, start_date.end_of_year.to_date)

      url = "http://www.gcatholic.org/calendar/#{end_date.year}/VN-vi.htm"
      service = GcatholicService.new(url)
      results2 = service.range(end_date.beginning_of_year.to_date, end_date)

      results = [results1, results2].flatten

      render json: results
    end
  end
end
