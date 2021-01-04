# frozen_string_literal: true

module Admin
  class ItemPolicy < ApplicationPolicy
    def create?
      return false unless user

      user.author? || user.admin?
    end

    def destroy?
      create?
    end

    def move_up?
      update?
    end

    def move_down?
      update?
    end

    def edit?
      create?
    end

    def update?
      create?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.all
      end
    end
  end
end
