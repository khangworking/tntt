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
  end
end
