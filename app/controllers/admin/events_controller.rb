class Admin::EventsController < AdminController
  def index
    fetch_events
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy!
    fetch_events
  end

  def create
    @event = Event.new(create_params)
    @event.save
    respond_to do |format|
      format.html { head :no_content }
      format.turbo_stream do
        fetch_events
      end
    end
  end

  private

  def create_params
    params.require(:event).permit(:title, :start_datetime)
  end

  def fetch_events
    @events = Event.page(params[:page]).per(25)
  end
end
