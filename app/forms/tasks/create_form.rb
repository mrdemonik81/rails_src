# frozen_string_literal: true

module Tasks
  class CreateForm < ApplicationForm
    attribute :name, String
    attribute :skill_ids, Array[Integer]
    attribute :domain_ids, Array[Integer]
    attribute :level_ids, Array[Integer]
    attribute :complexity, String, default: 'low'
    attribute :performance, Float, default: 1.0
    attribute :type, String

    validates :name, presence: true
    validates :complexity, inclusion: { in: Task.complexities.keys }
    validates :performance, inclusion: { in: 0.01..1 }
    validates :type, inclusion: { in: Task.types }

    def performance=(val)
      @performance = val.to_f
    end

    private

    def persist!
      Task.create!(attributes)
    end
  end
end
