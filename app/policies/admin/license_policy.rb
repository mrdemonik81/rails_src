# frozen_string_literal: true

module Admin
  class LicensePolicy < ApplicationPolicy
    def show?
      return false unless user

      !user.basic?
    end

    def new?
      return false unless user

      user.admin?
    end

    def update?
      new?
    end

    def create?
      new?
    end

    def destroy?
      new?
    end

    def undiscard?
      destroy?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.kept.includes(:licensable)
      end
    end
  end
end
