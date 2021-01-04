# frozen_string_literal: true

module ApplicationHelper
  def examination_status_tag(examination)
    content_tag :span, class: "badge #{examination_status_label_class(examination)}" do
      examination.status.to_s
    end
  end

  def examination_status_label_class(examination)
    case examination.status
    when 'pending'
      'badge-primary'
    when 'in_progress'
      'badge-danger'
    when 'completed'
      'badge-success'
    end
  end
end
