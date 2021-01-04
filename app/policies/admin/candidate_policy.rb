# frozen_string_literal: true

module Admin
  class CandidatePolicy < ApplicationPolicy
    def index?
      return false unless user

      !user.basic?
    end

    def new?
      index?
    end

    def create?
      index?
    end

    def edit?
      index? || candidate.clients.include?(user.clients)
    end

    def update?
      edit?
    end

    def destroy?
      user.admin?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.kept.includes(:clients)
      end
    end
  end
end
