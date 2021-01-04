# frozen_string_literal: true

# == Schema Information
#
# Table name: candidate_solutions
#
#  id                  :bigint           not null, primary key
#  examination_task_id :bigint
#  solution            :jsonb            not null
#  task_snapshot       :jsonb            not null
#  correct             :boolean          default(FALSE)
#  score               :integer
#  discarded_at        :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe CandidateSolution, type: :model do
  subject(:candidate_solution) { described_class.new }

  describe 'Table structure' do
    it { is_expected.to have_db_column(:examination_task_id).of_type(:integer).with_options(foreign_key: true) }
    it { is_expected.to have_db_column(:solution).of_type(:jsonb).with_options(default: {}, null: false) }
    it { is_expected.to have_db_column(:task_snapshot).of_type(:jsonb).with_options(default: {}, null: false) }
    it { is_expected.to have_db_column(:correct).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:score).of_type(:integer) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime).with_options(index: true) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:examination_task_id) }
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    before do
      allow(candidate_solution)
        .to receive_message_chain(:task, :manual_check?).and_return(false)
    end

    it { is_expected.to validate_presence_of(:solution) }
    it { is_expected.to validate_presence_of(:task_snapshot) }
    it { is_expected.to validate_presence_of(:score) }

    context "when score isn't required" do
      before do
        allow(candidate_solution)
          .to receive_message_chain(:task, :manual_check?).and_return(true)
      end

      it { is_expected.not_to validate_presence_of(:score) }
    end
  end

  describe 'Model relations' do
    before do
      allow(candidate_solution)
        .to receive_message_chain(:task, :manual_check?).and_return(false)
    end
    # it { is_expected.to have_many(:attachments_attachments) }

    it { is_expected.to belong_to(:examination_task) }
    it { is_expected.to have_one(:task) }
  end
end
