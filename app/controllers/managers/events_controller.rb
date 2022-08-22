class Managers::EventsController < ManagersController
  def index
    @mobile = request.user_agent =~ /Mobile|webOS/
  end
end
