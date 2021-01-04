# frozen_string_literal: true

# == Schema Information
#
# Table name: client_users
#
#  id           :bigint           not null, primary key
#  client_id    :bigint           not null
#  user_id      :bigint           not null
#  role         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

class ClientUser < ApplicationRecord
  include Discard::Model

  belongs_to :client
  belongs_to :user
  validates :user, :client, presence: true
  validates :user_id, uniqueness: { scope: :client_id }
  enum role: { basic: 0, tutor: 1, manager: 2 }
  enum status: { active: 0, closed: 1 }
end
