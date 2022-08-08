class Admin::LevelsController < AdminController
  def index
    @levels = Level.eager_load(:active_people)
                   .where(name: Level::STUDENT_NAMES)
                   .order(sort_order: :asc)
                   .page(params[:page]).per(25)
  end
end
