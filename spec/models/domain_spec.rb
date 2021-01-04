# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Domain, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Model relations' do
    it { is_expected.to have_and_belong_to_many(:tasks) }
  end
end
