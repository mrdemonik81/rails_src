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

FactoryBot.define do
  factory :client do
    name { 'MyString' }
    billing_info { 'MyText' }
    org_id { 'MyString' }
  end
end
