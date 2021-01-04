# frozen_string_literal: true

class TaskItemOptions::BasicForm < ApplicationForm
  def attributes(*args)
    super.except(:option)
  end
end
