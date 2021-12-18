class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!, :authorize

  private

  def authorize
    authorize! :show, :admin_dashboards
  end
end
