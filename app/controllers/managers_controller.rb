class ManagersController < ApplicationController
  before_action :authenticate_user!, :authorize
  layout 'manager'

  private

  def check_role
    redirect_to root_path unless current_user.person
  end

  def authorize
    authorize! :show, :manager_dashboards
  end
end
