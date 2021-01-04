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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model relations' do
    it { is_expected.to validate_presence_of(:fname) }
    it { is_expected.to validate_presence_of(:lname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to define_enum_for(:role).with_values(described_class.roles.keys) }
  end
end
