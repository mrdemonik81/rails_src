# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :find_current_user
  before_action :set_paper_trail_whodunnit

  private

  def find_current_user
    User.current = current_user
  end

  def user_not_authorized
    flash[:alert] = I18n.t('authorization_error')
    redirect_to(request.referer || root_path)
  end

  def layout_by_resource
    if devise_controller?
      'auth/index'
    else
      'application'
    end
  end
end
