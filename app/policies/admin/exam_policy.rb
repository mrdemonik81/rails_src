# frozen_string_literal: true

module Admin
  class ExamPolicy < ApplicationPolicy
    def index?
      return false unless user

      !user.basic?
    end

    def show?
      index?
    end

    def new?
      user.author? || user.admin?
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
      user.examiner? || user.admin?
    end

    def bulk_assign?
      assign_candidate?
    end

    def bulk_assign_post?
      assign_candidate?
    end

    def destroy?
      user.admin?
    end
  end
end
