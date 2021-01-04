# frozen_string_literal: true

# == Schema Information
#
# Table name: candidates
#
#  id           :bigint           not null, primary key
#  fname        :string
#  lname        :string
#  email        :string
#  mobile       :string
#  locale       :string
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gender       :integer          default("unknown"), not null
#  ssn          :string           default(""), not null
#

FactoryBot.define do
  factory :candidate do
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.cell_phone }
    locale { 0 }
    discarded_at { '2019-07-30 11:57:30' }
  end
end
