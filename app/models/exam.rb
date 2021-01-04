# frozen_string_literal: true

# == Schema Information
#
# Table name: exams
#
#  id           :bigint           not null, primary key
#  name         :string
#  published    :boolean          default(FALSE)
#  max_time     :integer
#  max_tasks    :integer
#  price        :decimal(6, 2)
#  algorithm    :integer          default("random")
#  result_type  :integer          default("minimal")
#  task_types   :text             default([]), is an Array
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#

class Exam < ApplicationRecord
  include Discard::Model
  require 'chronic_duration'

  has_many_attached :attachments
  has_one_attached :image
  has_many :examinations, dependent: :destroy
  has_many :exam_skills, dependent: :destroy
  has_many :skills, through: :exam_skills
  has_many :exam_domains, dependent: :destroy
  has_many :domains, through: :exam_domains
  has_many :exam_levels, dependent: :destroy
  has_many :levels, through: :exam_levels
  has_many :licenses, as: :licensable, dependent: :destroy

  enum algorithm: { random: 0, adaptive: 1 }
  enum result_type: { minimal: 0, detailed: 1, aggregated: 2 }

  validates :name, :max_time, :max_tasks, presence: true
  validates :max_time, :max_tasks, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def max_time_human
    ChronicDuration.output(max_time, format: :short, units: 2, limit_to_hours: true)
  end

  def max_time_human=(value)
    self.max_time = ChronicDuration.parse(value.to_s) || 0
  end
end
