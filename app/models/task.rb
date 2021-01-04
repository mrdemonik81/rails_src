# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id               :bigint           not null, primary key
#  name             :string
#  type             :string           not null
#  instruction      :text
#  introduction     :text
#  complexity       :integer          default("low")
#  performance      :float
#  ordered_solution :boolean          default(FALSE)
#  manual_check     :boolean          default(FALSE)
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string           default(""), not null
#  context          :jsonb            not null
#  published        :boolean          default(FALSE), not null
#  score_method     :integer          default("true_false"), not null
#

class Task < ApplicationRecord
  has_paper_trail
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :domains
  has_many :levels_tasks, dependent: :destroy
  has_many :levels, through: :levels_tasks

  enum complexity: { low: 0, medium: 1, high: 2 }
  enum score_method: { true_false: 0, fractional: 1, manual: 2 }

  def self.types
    subclasses.map(&:to_s)
  end

  def self.types_for_select
    types.map do |type|
      [I18n.t(type.underscore, scope: 'tasks.types'), type]
    end
  end

  def self.form
    const_get(:Form)
  end
end

require_dependency 'tasks/select_text'
require_dependency 'tasks/select_image'
require_dependency 'tasks/true_false'
require_dependency 'tasks/essay'
require_dependency 'tasks/audio'
require_dependency 'tasks/audio_dialogue'
require_dependency 'tasks/mark_word'
require_dependency 'tasks/arrange_words'
require_dependency 'tasks/fill_in_blanks'
