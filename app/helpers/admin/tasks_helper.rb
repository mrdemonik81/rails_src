# frozen_string_literal: true

module Admin
  module TasksHelper
    TASK_ICONS = {
      'Tasks::Audio' => 'fa-microphone-alt',
      'Tasks::Essay' => 'fa-pencil-alt',
      'Tasks::SelectText' => 'fa-tasks',
      'Tasks::MarkWord' => 'fa-paint-roller',
      'Tasks::FillInBlanks' => 'fa-font',
      'Tasks::InlineDropdown' => 'fa-caret-square-down',
      'Tasks::SelectImage' => 'fa-images',
      'Tasks::ArrangeWords' => 'fa-hand-point-up',
      'Tasks::AudioDialogue' => 'fa-comments',
      'Tasks::TrueFalse' => 'fa-check'
    }.freeze

    def task_icon_class(task)
      TASK_ICONS.fetch(task.type, 'fa-question-circle')
    end
  end
end
