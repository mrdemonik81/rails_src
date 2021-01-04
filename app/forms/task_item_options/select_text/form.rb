# frozen_string_literal: true

class TaskItemOptions::SelectText::Form < TaskItemOptions::BasicForm
  attribute :option, TaskItemOptions::SelectText

  attribute :answer, String
  attribute :correct, Axiom::Types::Boolean, default: false

  validates :answer, presence: true

  def self.params_schema
    %i[correct answer]
  end
end
