class Admin::LevelsController < AdminController
  def index
    @levels = Level.includes(:active_people).page(params[:page]).per(25)
  end
end
