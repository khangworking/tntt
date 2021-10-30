class Admin::DashboardsController < AdminController
  def show
    @seniors_n_juniors = Person.joins(:level)
                               .where(levels: { name: %w(senior junior) })
                               .where(active: true)
  end
end
