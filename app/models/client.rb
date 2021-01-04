# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  name         :string
#  billing_info :text
#  org_id       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

class Client < ApplicationRecord
  include Discard::Model

  has_many :client_candidates, dependent: :destroy
  has_many :candidates, through: :client_candidates
  has_many :client_users, dependent: :destroy
  has_many :users, through: :client_users
  has_many :examinations, through: :client_candidates
  has_many :licenses, dependent: :destroy

  validates :name, presence: true

  after_discard do
    client_candidates.discard_all
    client_users.discard_all
  end

  after_undiscard do
    client_candidates.undiscard_all
    client_users.undiscard_all
  end
end
