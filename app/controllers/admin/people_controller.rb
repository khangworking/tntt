class Admin::PeopleController < AdminController
  def index
    @people = Person.where(active: true)
                    .eager_load(:level)
                    .order(:created_at)
  end

  def show
    @person = Person.where(active: true).find(params[:id])
  end
end
