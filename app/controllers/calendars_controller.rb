class CalendarsController < ApplicationController
  def index
    @mobile = request.user_agent =~ /Mobile|webOS/
  end
end
