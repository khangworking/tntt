class ManagersController < ApplicationController
  before_action :authenticate_user!, :authorize
  layout 'manager'

  private

  def authorize
    authorize! :show, :manager_dashboards
  end
end
