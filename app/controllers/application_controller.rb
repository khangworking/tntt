class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale]
  end

  def layout_by_resource
    if devise_controller?
      "blank_center"
    else
      "application"
    end
  end
end
