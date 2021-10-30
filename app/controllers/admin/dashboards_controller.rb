class Admin::DashboardsController < AdminController
  def show
    month = Time.zone.now.month
    next_month = (Time.zone.now + 1.month).month
    @months, @next_months = Person.where(active: true)
                                  .where('extract(month from feastday) IN (?)', [month, next_month])
                                  .order(:feastday)
                                  .group_by { |person| person.feastday.month }
                                  .values
  end
end
