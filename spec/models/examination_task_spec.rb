# frozen_string_literal: true

# == Schema Information
#
# Table name: examination_tasks
#
#  id             :bigint           not null, primary key
#  examination_id :bigint
#  task_id        :bigint
#  score          :integer
#  time_spent     :integer
#  discarded_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe ExaminationTask, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:examination_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:task_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:score).of_type(:integer) }
    it { is_expected.to have_db_column(:time_spent).of_type(:integer) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:examination_id) }
    it { is_expected.to have_db_index(:task_id) }
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_numericality_of(:time_spent).is_greater_than(0).allow_nil }
    it { is_expected.to validate_numericality_of(:score).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:examination) }
    it { is_expected.to belong_to(:task) }
    it { is_expected.to have_one(:candidate_solution) }
  end
end
