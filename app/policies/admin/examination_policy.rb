# frozen_string_literal: true

module Admin
  class ExaminationPolicy < ApplicationPolicy
    def index?
      return false unless user

      !user.basic?
    end

    def show?
      new?
    end

    def new?
      user.examiner? || user.admin?
    end

    def update?
      new?
    end

    def create?
      new?
    end

    def examinations?
      index?
    end

    def assign_candidate?
      new?
    end

    def bulk_assign?
      new?
    end

    def destroy?
      user.admin? && record.pending?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.kept.includes(:client_candidate, :exam)
      end
    end
  end
end
