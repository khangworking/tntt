module ApplicationHelper
  def dashboard_controller?
    controller_name == 'dashboards'
  end

  def people_controller?
    controller_name == 'people'
  end
end
