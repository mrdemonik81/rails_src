# frozen_string_literal: true

class Tasks::Audio::Form < Tasks::BasicForm
  attribute :task, Tasks::Audio

  attribute :title, String, default: ->(form, _attribute) { form.task.title }
  attribute :instruction, String, default: ->(form, _attribute) { form.task.instruction }
  attribute :audio, ActiveStorage::Attached::One
  attribute :introduction, String, default: ->(form, _attribute) { form.task.introduction }
  attribute :score_method, Integer, default: ->(form, _attribute) { form.task&.score_method }
  validates :score_method, inclusion: { in: Task.score_methods.keys }
  validates :title, presence: true
  validates :instruction, presence: true
  validates :audio,
            file_size: {
              less_than_or_equal_to: 20.megabytes,
              message: 'Audio should be less than %{count}'
            },
            file_content_type: {
              allow: %w[audio/mpeg audio/x-mpeg audio/mp3 audio/x-mp3 audio/mpeg3 audio/x-mpeg3]
            }

  def self.params_schema
    %i[title instruction minimum_duration introduction audio score_method]
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
      @task.update(attributes.slice(:title, :instruction, :minimum_duration, :introduction))
    end
  end
end
