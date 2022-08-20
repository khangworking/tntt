class HomeController < ApplicationController
  def index
    url = "http://www.gcatholic.org/calendar/#{Time.zone.now.year}/VN-vi.htm"
    service = GcatholicService.new(url)
    @catholic_today = service.today
    @next_feasts = Person.next_feastday_persons
    @day = @next_feasts.keys.first
    feast_arr = service.calc_day(@day.day, @day.month, @day.year)
    @feast_str = if feast_arr.length > 1
                   feast_arr.select { |str| str.include?('feast') }.map { |str| str.split(':')[1] }.join(', ')
                 else
                   feast_arr[0]
                 end
  end
end
