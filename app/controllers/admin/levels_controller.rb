class Admin::LevelsController < AdminController
  def index
    @levels = Level.eager_load(:active_people)
                   .page(params[:page]).per(25)
  end
end
