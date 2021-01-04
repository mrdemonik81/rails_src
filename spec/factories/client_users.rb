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

FactoryBot.define do
  factory :client_user do
    client { nil }
    user { nil }
  end
end
