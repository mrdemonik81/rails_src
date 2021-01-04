# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin/admin'

  def policy(record)
    policy_class.new(current_user, record)
  rescue NameError
    super
  end
  helper_method :policy
end
