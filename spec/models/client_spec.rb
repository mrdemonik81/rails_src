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

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:org_id).of_type(:string) }
    it { is_expected.to have_db_column(:billing_info).of_type(:text) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Model relations' do
    it { is_expected.to have_many(:examinations) }
    it { is_expected.to have_many(:client_candidates) }
    it { is_expected.to have_many(:client_users) }
  end
end
