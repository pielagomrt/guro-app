class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(*)
    new_teacher_registration_path
  end
end
