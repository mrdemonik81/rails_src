# frozen_string_literal: true

# == Schema Information
#
# Table name: examinations
#
#  id                  :bigint           not null, primary key
#  exam_id             :bigint
#  expires_at          :datetime
#  total_score         :integer          default(0), not null
#  total_time_spent    :integer          default(0), not null
#  status              :integer          default("pending")
#  meta                :jsonb            not null
#  discarded_at        :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#  client_candidate_id :bigint
#

class Examination < ApplicationRecord
  has_paper_trail
  include Discard::Model

  belongs_to :exam
  belongs_to :client_candidate
  has_many :examination_tasks, dependent: :destroy
  delegate :client, to: :client_candidate, allow_nil: true
  delegate :candidate, to: :client_candidate, allow_nil: true

  store_accessor :meta, %i[comment]
  enum status: { pending: 0, in_progress: 1, completed: 2, pending_review: 3, reviewed: 4 }
  scope :by_examiner, ->(id) { where('examinations.user_id = ?', id) if id.present? }

  validates :exam, :client_candidate, presence: true
  validates :total_time_spent, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :total_score, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def total_time_spent_human
    ChronicDuration.output(total_time_spent, format: :short, units: 2, limit_to_hours: true)
  end

  def total_time_spent_human=(value)
    self.total_time_spent = ChronicDuration.parse(value.to_s) || 0
  end
end
