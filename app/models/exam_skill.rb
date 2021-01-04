# frozen_string_literal: true

# == Schema Information
#
# Table name: exam_skills
#
#  id       :bigint           not null, primary key
#  exam_id  :bigint
#  skill_id :bigint
#

class ExamSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :exam
end
