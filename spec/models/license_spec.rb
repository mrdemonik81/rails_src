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

require 'rails_helper'

RSpec.describe License, type: :model do
  describe 'Model versioning' do
    it { is_expected.to be_versioned }
  end
end
