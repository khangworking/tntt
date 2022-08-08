class Admin::LevelsController < AdminController
  before_action :find_level, only: %i[edit update]

  def index
    @levels = Level.eager_load(:active_people)
                   .where(name: Level::STUDENT_NAMES)
                   .order(sort_order: :asc)
                   .page(params[:page]).per(25)
  end

  def update
    if @level.update(update_params)
      flash[:success] = 'Updated'
    else
      flash[:danger] = 'Fail to update'
    end
    redirect_to edit_admin_level_path(@level)
  end

  private

  def find_level
    @level = Level.find(params[:id])
  end

  def update_params
    params.require(:level).permit(managers_attributes: %i[person_id role _destroy id])
  end
end
