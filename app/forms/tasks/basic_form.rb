# frozen_string_literal: true

class Tasks::BasicForm < ApplicationForm
  def attributes(*args)
    super.except(:task)
  end

  def self.model_name
    Task.model_name
  end
end
