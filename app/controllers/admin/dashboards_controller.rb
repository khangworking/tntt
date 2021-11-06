class Admin::DashboardsController < AdminController
  def show
    @feastday_persons = Person.next_feastday_persons
    @leader = Person.leader.take
    @vice_leader = Person.vice_leader.take
    @seniors_n_juniors = Person.joins(:level)
                               .where(levels: { name: Level::LEADER_NAMES })
                               .where(active: true)
                               .order(created_at: :desc)
  end
end
