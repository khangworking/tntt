class Admin::PeopleController < AdminController
  def index
    @people = Person.where(active: true)
                    .eager_load(:level)
                    .order(:feastday)
  end
end
