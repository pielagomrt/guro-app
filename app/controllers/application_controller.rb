class ApplicationController < ActionController::Base
  include Exceptions::ApplicationErrors
  rescue_from CreationProcessError, with: :handle_creation_process_error
  rescue_from BadRequestError, with: :handle_bad_request_error
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :subject) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
  end

  def handle_creation_process_error(error)
    flash[:alert] = error.resource.errors.full_messages.first
    redirect_to(error.path)
  end

  def handle_bad_request_error(error)
    flash[:alert] = error.message
    redirect_to(error.path)
  end
end
