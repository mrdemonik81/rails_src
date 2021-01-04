# frozen_string_literal: true

class Tasks::AudioDialogue::Form < Tasks::BasicForm
  attribute :task, Tasks::AudioDialogue
  attribute :title,
            String,
            default: ->(form, _attr) { form.task&.title }
  attribute :instruction,
            String,
            default: ->(form, _attr) { form.task&.instruction }
  attribute :score_method, Integer, default: ->(form, _attribute) { form.task&.score_method }

  validates :title, presence: true
  validates :score_method, inclusion: {
    in: (Task.score_methods.keys - %w[true_false fractional]),
    message: I18n.t('invalid_score_method')
  }

  def self.params_schema
    %i[title instruction score_method]
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    ActiveRecord::Base.transaction do
      @task.update(attributes.slice(:title, :score_method, :instruction))
    end
  end
end
