# frozen_string_literal: true

module Admin
  class ClientPolicy < ApplicationPolicy
    def index?
      return false unless user

      !user.basic?
    end

    def new?
      index?
    end

    def create?
      new?
    end

    def show?
      index?
    end

    def update?
      index?
    end

    def candidates?
      index?
    end

    def add_user?
      index?
    end

    def examinations?
      index?
    end

    def licenses?
      user.admin?
    end

    def destroy?
      user.admin?
    end
  end
end
