class Managers::PeopleController < ManagersController
  def index
    @levels = Level.accessible_by(current_ability)
                   .where(name: Level::STUDENT_NAMES)
    @selected_level = Level.find(params[:level_id] || @levels.ids.first)
    @presence = @selected_level.people_presences.today
    @managers = Manager.includes(:level, person: :level)
                       .where(levels: { id: @selected_level })
    @people = Person.accessible_by(current_ability)
                    .where(active: true)
                    .eager_load(:level)
                    .where.not(levels: { name: Level::LEADER_NAMES })
                    .where(levels: { id: @selected_level })
                    .order_name_alphabel
  end

  def show
    @person = Person.find(params[:id])
    authorize! :read, @person
    render :show
  end

  def edit
    @person = Person.find(params[:id])
    authorize! :update, @person
    render :edit
  end

  def update
    @person = Person.find(params[:id])
    authorize! :update, @person
    if @person.update(update_params)
      flash[:notice] = t('.success')
      redirect_to managers_person_path(id: @person)
    else
      flash[:alert] = t('common.went_wrong')
      render :edit
    end
  end

  private

  def update_params
    params.require(:person)
          .permit(:birthday, :christain_name, :feastday, :fullname, :gender, :phone, :address)
  end
end
