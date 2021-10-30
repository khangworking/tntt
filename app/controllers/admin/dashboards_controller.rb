class Admin::DashboardsController < AdminController
  def show
    @people = Person.eager_load(:level)
                    .where(levels: { name: %w(senior junior) })
                    .where(active: true)
  end
end
