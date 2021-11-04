class Admin::DashboardsController < AdminController
  def show
    @feastday_persons = Person.next_feastday_persons
    @seniors_n_juniors = Person.joins(:level)
                               .where(levels: { name: %w(senior junior) })
                               .where(active: true)
                               .order(created_at: :desc)
  end
end
