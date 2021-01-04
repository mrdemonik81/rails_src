# frozen_string_literal: true

# == Schema Information
#
# Table name: exam_levels
#
#  id       :bigint           not null, primary key
#  exam_id  :bigint
#  level_id :bigint
#

class ExamLevel < ApplicationRecord
  belongs_to :level
  belongs_to :exam
end
