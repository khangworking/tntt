module ApplicationHelper
  def dashboard_controller?
    controller_name == 'dashboards'
  end

  def people_controller?
    controller_name == 'people' && action_name == 'index'
  end

  def students_controller?
    controller_name == 'students'
  end

  def breadcrumb
    if dashboard_controller?
      'Dashboard'
    elsif people_controller?
      'People'
    elsif students_controller?
      'Students'
    end
  end
end
