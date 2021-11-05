class Admin::DashboardsController < AdminController
  def show
    @feastday_persons = Person.next_feastday_persons
    level_name = %w(du_truong huynh_truong1 huynh_truong2 huynh_truong3)
    @seniors_n_juniors = Person.joins(:level)
                               .where(levels: { name: level_name })
                               .where(active: true)
                               .order(created_at: :desc)
  end
end
