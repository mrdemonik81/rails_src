# frozen_string_literal: true

# == Schema Information
#
# Table name: client_candidates
#
#  id           :bigint           not null, primary key
#  client_id    :bigint           not null
#  candidate_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

FactoryBot.define do
  factory :client_candidate do
    client
    candidate
  end
end
