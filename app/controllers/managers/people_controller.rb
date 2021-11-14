class Managers::PeopleController < ManagersController
  def index
    @levels = Level.where(name: Level::STUDENT_NAMES)
    @managers = Manager.includes(:level, person: :level)
                       .where(levels: { name: level_filter })
    @people = Person.where(active: true)
                    .eager_load(:level)
                    .where.not(levels: { name: Level::LEADER_NAMES })
                    .where(levels: { name: level_filter })
                    .order_name_alphabel
  end

  def show
    @person = Person.where(active: true).find(params[:id])
  end

  def level_filter
    return 'chien_con1' if !params[:level] || !params[:level].in?(Level::STUDENT_NAMES)

    params[:level]
  end
end
