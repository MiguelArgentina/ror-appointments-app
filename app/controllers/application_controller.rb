class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:welcome]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cellphone, :user_type])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:cellphone, :user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:cellphone, :user_type])
  end
end
