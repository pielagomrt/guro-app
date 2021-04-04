# frozen_string_literal: true

class Teachers::RegistrationsController < Devise::RegistrationsController
  layout 'landing'

  protected

  def after_inactive_sign_up_path_for(*)
    new_teacher_registration_path
  end

  def after_update_path_for(*)
    dashboard_path
  end
end
