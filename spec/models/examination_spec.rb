# frozen_string_literal: true

# == Schema Information
#
# Table name: examinations
#
#  id                  :bigint           not null, primary key
#  exam_id             :bigint
#  expires_at          :datetime
#  total_score         :integer          default(0), not null
#  total_time_spent    :integer          default(0), not null
#  status              :integer          default("pending")
#  meta                :jsonb            not null
#  discarded_at        :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#  client_candidate_id :bigint
#

require 'rails_helper'

RSpec.describe Examination, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:exam_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:client_candidate_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:expires_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:total_score).of_type(:integer) }
    it { is_expected.to have_db_column(:status).of_type(:integer).with_options(default: :pending) }
    it { is_expected.to have_db_column(:meta).of_type(:jsonb).with_options(default: {}, null: false) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:exam_id) }
    it { is_expected.to have_db_index(:client_candidate_id) }
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    it { is_expected.to define_enum_for(:status).with_values(described_class.statuses.keys) }
    it { is_expected.to validate_numericality_of(:total_time_spent).is_greater_than_or_equal_to(0).allow_nil }
    it { is_expected.to validate_numericality_of(:total_score).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:exam) }
    it { is_expected.to belong_to(:client_candidate) }
    it { is_expected.to have_many(:examination_tasks) }
  end

  describe 'Model versioning' do
    it { is_expected.to be_versioned }
  end
end
