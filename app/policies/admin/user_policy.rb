# frozen_string_literal: true

module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      return false unless user

      !user.basic?
    end

    def edit?
      index?
    end

    def update?
      index?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.kept
      end
    end
  end
end
