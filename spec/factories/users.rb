# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  fname                  :string
#  lname                  :string
#  email                  :string
#  mobile                 :string
#  locale                 :string
#  role                   :integer          default("basic")
#  status                 :integer          default("active")
#  meta                   :jsonb            not null
#  discarded_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

FactoryBot.define do
  factory :user do
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password123' }
    mobile { Faker::PhoneNumber.cell_phone }
    locale { 'en' }
    role { 0 }
    trait :removed do
      discarded_at { 30.days.ago }
    end
    trait :with_admin_role do
      role { :admin }
    end
    trait :with_google_identity do
      after(:create) do |user|
        create(:identity, :from_google, user: user)
      end
    end
  end
end
