# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id               :bigint           not null, primary key
#  name             :string
#  type             :string           not null
#  instruction      :text
#  introduction     :text
#  complexity       :integer          default("low")
#  performance      :float
#  ordered_solution :boolean          default(FALSE)
#  manual_check     :boolean          default(FALSE)
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string           default(""), not null
#  context          :jsonb            not null
#  published        :boolean          default(FALSE), not null
#  score_method     :integer          default("true_false"), not null
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:context).of_type(:jsonb).with_options(default: {}, null: false) }
  end

  describe 'Model validations' do
    it { is_expected.to define_enum_for(:complexity).with_values(described_class.complexities.keys) }
  end

  describe 'Model relations' do
    it { is_expected.to have_and_belong_to_many(:skills) }
    it { is_expected.to have_and_belong_to_many(:domains) }
  end

  describe 'Model versioning' do
    it { is_expected.to be_versioned }
  end
end
