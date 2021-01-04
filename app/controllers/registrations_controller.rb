# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :fname, :lname)
    end
  end
end
