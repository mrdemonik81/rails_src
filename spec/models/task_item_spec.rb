# frozen_string_literal: true

# == Schema Information
#
# Table name: task_items
#
#  id           :bigint           not null, primary key
#  task_id      :bigint
#  type         :string           not null
#  context      :jsonb            not null
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  position     :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe TaskItem, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:task_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:context).of_type(:jsonb).with_options(default: {}, null: false) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:task_id) }
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model relations' do
    # it { is_expected.to have_many(:attachments_attachments) }
    it { is_expected.to belong_to(:task) }
  end

  describe 'Model versioning' do
    it { is_expected.to be_versioned }
  end
end
