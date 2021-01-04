# frozen_string_literal: true

# == Schema Information
#
# Table name: levels_tasks
#
#  level_id :bigint
#  task_id  :bigint
#

class LevelsTask < ApplicationRecord
  belongs_to :level
  belongs_to :task
end
