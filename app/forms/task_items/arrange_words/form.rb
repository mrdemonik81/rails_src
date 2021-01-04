# frozen_string_literal: true

class TaskItems::ArrangeWords::Form < TaskItems::BasicForm
  attribute :item, TaskItems::ArrangeWords
  attribute :arrange_words, String, default: ->(form, _attr) { form.item&.arrange_words }
  attribute :additional_words, String, default: ->(form, _attr) { form.item&.additional_words }
  validates :arrange_words, presence: true
  validates :additional_words, presence: false

  def self.params_schema
    %i[arrange_words additional_words]
  end
end
