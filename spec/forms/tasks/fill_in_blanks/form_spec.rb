# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::FillInBlanks::Form, type: :model do
  let!(:fill_in_blanks) { build_stubbed(:fill_in_blanks) }
  let(:valid_params) do
    {
      task: fill_in_blanks,
      introduction: 'Introduction',
      instruction: 'Instructions'
    }
  end
  let(:invalid_params) { valid_params.merge(introduction: nil) }

  describe '#persist!' do
    context 'when FillInBlanksTask form valid' do
      subject(:task_form) { described_class.new(valid_params) }

      it { is_expected.to be_valid }

      it { expect(task_form.valid?).to eq(true) }
    end

    context 'when FillInBlanks form invalid' do
      subject(:task_form) { described_class.new(invalid_params) }

      it { is_expected.not_to be_valid }

      it { expect(task_form.valid?).to eq(false) }
    end
  end

  describe 'Model validations' do
    subject { described_class.new(task: Task.new) }

    it { is_expected.to validate_presence_of(:introduction) }
  end
end
