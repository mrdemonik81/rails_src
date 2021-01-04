# frozen_string_literal: true

# == Schema Information
#
# Table name: candidate_solutions
#
#  id                  :bigint           not null, primary key
#  examination_task_id :bigint
#  solution            :jsonb            not null
#  task_snapshot       :jsonb            not null
#  correct             :boolean          default(FALSE)
#  score               :integer
#  discarded_at        :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class CandidateSolution < ApplicationRecord
  has_many_attached :attachments
  belongs_to :examination_task
  has_one :task, through: :examination_task

  validates :solution, :task_snapshot, presence: true
  validates :score, presence: { unless: -> { task.manual_check? } }
  # TODO: Might be needed set default values as 0 for score
end
