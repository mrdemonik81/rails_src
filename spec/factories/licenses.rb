# frozen_string_literal: true

# == Schema Information
#
# Table name: licenses
#
#  id              :bigint           not null, primary key
#  client_id       :bigint           not null
#  licensable_type :string
#  licensable_id   :bigint
#  amount          :integer          default(1), not null
#  expires_at      :date
#  discarded_at    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :license do
    client { nil }
    exam { nil }
    amount { 1 }
  end
end
