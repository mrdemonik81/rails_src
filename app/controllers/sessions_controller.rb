# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    result = Auth::Pipelines::OmniauthAuthenticate.call(oauth_hash: auth_hash)
    if result.success?
      sign_in(:user, result.value[:user])
      redirect_to redirect_back_path, notice: t('success_signed_in')
    else
      redirect_to redirect_back_path, alert: result.value
    end
  end

  def destroy
    sign_out(:user)
    redirect_back(fallback_location: root_path, notice: t('success_signed_out'))
  end

  alias google_oauth2 create

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def redirect_back_path
    session.delete(:redirect_back) || root_path
  end
end
