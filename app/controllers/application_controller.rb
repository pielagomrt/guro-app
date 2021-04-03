class ApplicationController < ActionController::Base
  include Exceptions::ApplicationErrors
  rescue_from CreateGradingSystemError, with: :create_grading_system_error
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :subject) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
  end

  def create_grading_system_error(error)
    flash[:alert] = error.alert
    redirect_to(new_grading_system_form_path)
  end
end
