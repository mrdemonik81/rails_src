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

class ClientCandidate < ApplicationRecord
  include Discard::Model

  belongs_to :client
  belongs_to :candidate
  has_many :examinations, dependent: :destroy
  validates :client, :candidate, presence: true
end
