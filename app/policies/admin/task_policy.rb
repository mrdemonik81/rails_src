# frozen_string_literal: true

module Admin
  class TaskPolicy < ApplicationPolicy
    def index?
      return false unless user

      user.author? || user.admin?
    end

    def new?
      index?
    end

    def settings?
      index?
    end

    def update_settings?
      index?
    end

    def edit?
      index?
    end

    def update?
      index?
    end

    def toggle_published?
      index?
    end

    def create?
      index?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.all.order(id: :desc)
      end
    end
  end
end
