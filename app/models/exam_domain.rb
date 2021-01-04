# frozen_string_literal: true

# == Schema Information
#
# Table name: exam_domains
#
#  id        :bigint           not null, primary key
#  exam_id   :bigint
#  domain_id :bigint
#

class ExamDomain < ApplicationRecord
  belongs_to :domain
  belongs_to :exam
end
