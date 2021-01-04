# frozen_string_literal: true

class TaskItems::InlineDropdown::Form < TaskItems::BasicForm
  attribute :item, TaskItems::InlineDropdown
  attribute :statement, String, default: ->(form, _attr) { form.item&.statement }
  validates :statement, presence: true

  def self.params_schema
    %i[statement]
  end
end
