# frozen_string_literal: true

# == Schema Information
#
# Table name: levels
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  short_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Level < ApplicationRecord
  has_many :levels_tasks, dependent: :destroy
  has_many :tasks, through: :levels_tasks
  has_many :exam_levels, dependent: :destroy
  has_many :exams, through: :exam_levels
  validates :name, presence: true
  validates :short_name, presence: true, uniqueness: true

  def long
    "#{short_name} - #{name}"
  end
end
