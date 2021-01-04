# frozen_string_literal: true

class TaskItems::SelectImage::Form < TaskItems::BasicForm
  attribute :item, TaskItems::SelectImage
  attribute :question, String, default: ->(form, _attr) { form.item&.question }
  validates :question, presence: true

  def self.params_schema
    %i[question]
  end
end
