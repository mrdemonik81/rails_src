# frozen_string_literal: true

module Tasks
  class UpdateForm < BasicForm
    attribute :task, Task
    attribute :published, Boolean, default: ->(form, _attribute) { form.task.published }
    attribute :name, String, default: ->(form, _attribute) { form.task.name }
    attribute :skill_ids, Array[Integer], default: ->(form, _attribute) { form.task.skill_ids }
    attribute :domain_ids, Array[Integer], default: ->(form, _attribute) { form.task.domain_ids }
    attribute :level_ids, Array[Integer], default: ->(form, _attribute) { form.task.level_ids }
    attribute :complexity, String, default: ->(form, _attribute) { form.task.complexity }
    attribute :performance, Float, default: ->(form, _attribute) { form.task.performance }

    validates :complexity, inclusion: { in: Task.complexities.keys }
    validates :name, presence: true
    validates :performance, inclusion: { in: 0.01..1 }

    def performance=(val)
      @performance = val.to_f
    end

    private

    def persist!
      Task.update!(attributes)
    end
  end
end
