class Admin::PeopleController < AdminController
  def index
    @people = Person.where(active: true)
                    .eager_load(:level)
                    .where.not(levels: { name: Level::LEADER_NAMES })
                    .order(created_at: :desc)
  end

  def show
    @person = Person.where(active: true).find(params[:id])
  end
end
