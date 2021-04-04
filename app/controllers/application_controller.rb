class ApplicationController < ActionController::Base
  include Exceptions::ApplicationErrors
  rescue_from CreationProcessError, with: :creation_process_error_handler
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :subject) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
  end

  def creation_process_error_handler(error)
    flash[:alert] = error.resource.errors.full_messages.first
    redirect_to(error.path)
  end
end
