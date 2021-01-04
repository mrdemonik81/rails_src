# frozen_string_literal: true

# == Schema Information
#
# Table name: examination_tasks
#
#  id             :bigint           not null, primary key
#  examination_id :bigint
#  task_id        :bigint
#  score          :integer
#  time_spent     :integer
#  discarded_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ExaminationTask < ApplicationRecord
  belongs_to :examination
  belongs_to :task
  has_one :candidate_solution, dependent: :destroy

  validates :time_spent, numericality: { greater_than: 0, allow_nil: true }
  validates :score, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  # TODO: Might be needed set default values as 0 for score
end
