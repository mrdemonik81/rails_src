# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::SelectText::Form, type: :model do
  let!(:select_text) { build_stubbed(:select_text) }
  let(:valid_params) do
    {
      task: select_text,
      introduction: 'Introduction',
      instruction: 'Instructions'
    }
  end
  let(:invalid_params) { valid_params.merge(introduction: nil) }

  describe '#persist!' do
    context 'when SelectTextTask form valid' do
      subject(:task_form) { described_class.new(valid_params) }

      it { expect(task_form.valid?).to eq(true) }
    end

    context 'when SelectTextTask form invalid' do
      subject(:task_form) { described_class.new(invalid_params) }

      it { expect(task_form.valid?).to eq(false) }
    end
  end

  describe 'Model validations' do
    subject { described_class.new(task: Task.new) }

    it { is_expected.to validate_presence_of(:introduction) }
  end
end
