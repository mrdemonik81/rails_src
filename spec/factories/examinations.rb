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

FactoryBot.define do
  factory :examination do
    exam
    client_candidate
    expires_at { '2019-07-30 12:51:13' }
    total_score { 1 }
    total_time_spent { 1 }
    status { '' }
    meta { '' }
    discarded_at { '2019-07-30 11:57:30' }
  end
end
