class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :phone, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :email, :password, :password_confirmation, :current_password])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || :vi
  end

  def layout_by_resource
    if devise_controller?
      "blank_center"
    else
      "application"
    end
  end
end
