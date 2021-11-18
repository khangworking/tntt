class Managers::PeoplePresencesController < ManagersController
  def new
    prepare_form(params[:level_id])
  end

  def create
    obj = PeoplePresence.new(create_params)
    if obj.save
      flash[:notice] = t('.success')
      redirect_to managers_people_path
    else
      flash[:alert] = t('.fail')
      prepare_form(obj.level_id)
      render 'new'
    end
  end

  def edit
    prepare_edit
  end

  def update
    obj = PeoplePresence.find(params[:id])
    if obj.update(update_params)
      flash[:notice] = t('.success')
      redirect_to managers_people_path
    else
      flash[:alert] = t('.fail')
      prepare_edit
      render 'edit'
    end
  rescue ActionController::ParameterMissing
    flash[:alert] = t('.fail')
    prepare_edit
    render 'edit'
  end

  private

  def create_params
    params.require(:people_presence).permit(:user_id, :level_id, person_ids: [])
  end

  def update_params
    params.require(:people_presence).permit(person_ids: [])
  end

  def prepare_form(level_id)
    @presence = PeoplePresence.new(
      user: current_user,
      level_id: level_id
    )
    @people = Person.where(active: true)
                    .joins(:level)
                    .where(levels: { id: level_id })
  end

  def prepare_edit
    @presence = PeoplePresence.find(params[:id])
    @people = Person.where(active: true)
                    .joins(:level)
                    .where(levels: { id: @presence.level_id })
  end
end
