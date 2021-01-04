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

require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:fname).of_type(:string) }
    it { is_expected.to have_db_column(:lname).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(index: { unique: true }) }
    it { is_expected.to have_db_column(:mobile).of_type(:string) }
    it { is_expected.to have_db_column(:locale).of_type(:string) }
    it { is_expected.to have_db_column(:gender).of_type(:integer) }
    it { is_expected.to have_db_column(:ssn).of_type(:string) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:email) }
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:fname) }
    it { is_expected.to validate_presence_of(:lname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Model relations' do
    it { is_expected.to have_many(:examinations) }
  end
end
