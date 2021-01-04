# frozen_string_literal: true

class Tasks::InlineDropdown::Form < Tasks::BasicForm
  attribute :task, Tasks::InlineDropdown
  attribute :title, String, default: ->(form, _attr) { form.task&.title }
  attribute :instruction,
            String,
            default: ->(form, _attr) { form.task&.instruction }
  attribute :introduction,
            String,
            default: ->(form, _attr) { form.task&.introduction }
  attribute :audio, ActiveStorage::Attached::One
  attribute :score_method, Integer, default: ->(form, _attribute) { form.task&.score_method }
  validates :score_method, inclusion: { in: Task.score_methods.keys }
  validates :introduction, presence: true
  validates :title, presence: true
  attribute :audio,
            ActiveStorage::Attached::One,
            default: ->(form, _attr) { form.task&.audio }
  validates :audio,
            file_size: {
              less_than_or_equal_to: 20.megabytes,
              message: 'Audio should be less than %{count}'
            },
            file_content_type: {
              allow: %w[audio/mpeg audio/x-mpeg audio/mp3 audio/x-mp3 audio/mpeg3 audio/x-mpeg3]
            }

  def self.params_schema
    %i[instruction introduction audio title score_method]
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
      @task.update(attributes.slice(:instruction, :introduction, :title))
    end
  end
end
