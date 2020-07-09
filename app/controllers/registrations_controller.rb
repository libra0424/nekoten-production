# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(resouce)
    user_path(resouce)
  end

  def after_inactive_sign_up_path_for(resource)
    confirm_email_path
  end
  
end
