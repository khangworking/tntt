class ManagersController < ApplicationController
  before_action :authenticate_user!, :check_role
  layout 'manager'

  private

  def check_role
    redirect_to root_path unless current_user.person
  end
end
