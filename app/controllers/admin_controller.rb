class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!, :authorize, :set_locale

  private

  def authorize
    authorize! :show, :admin_dashboards
  end

  def set_locale
    I18n.locale = :vi
  end
end
