class ApplicationController < ActionController::Base
  include Exceptions::ApplicationErrors
  rescue_from CreationProcessError, with: :handle_creation_process_error
  rescue_from InvalidScoresError, with: :handle_invalid_scores_error
  before_action :update_allowed_parameters, if: :devise_controller?

  def respond_success(message, path)
    flash[:notice] = message
    redirect_to(path)
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:subject, :first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:subject, :first_name, :last_name, :email, :password, :current_password) }
  end

  def after_sign_in_path_for(*)
    dashboard_path
  end

  def handle_creation_process_error(error)
    flash[:alert] = error.resource.errors.full_messages.first
    redirect_to(error.path)
  end

  def handle_invalid_scores_error(error)
    flash[:alert] = error.message
    redirect_to(error.path)
  end
end
