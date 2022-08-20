class ManagersController < ApplicationController
  before_action :authenticate_user!, :authorize
  private

  def authorize
    authorize! :show, :manager_dashboards
  end
end
