# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::AudioDialogue::Form, type: :model do
  let(:valid_params) do
    {
      title: 'Audio Dialogue',
      instruction: 'Instruction',
      score_method: 'manual'
    }
  end
  let(:invalid_params) { valid_params.merge(title: nil) }

  describe '#persist!' do
    context 'when AudioDialogueTask form valid' do
      subject(:task_form) { described_class.new(valid_params) }

      it { expect(task_form.valid?).to eq(true) }
    end

    context 'when AudioDialogueTask form invalid' do
      subject(:task_form) { described_class.new(invalid_params) }

      it { expect(task_form.valid?).to eq(false) }
    end
  end

  describe 'Model validations' do
    subject { described_class.new(task: Task.new) }

    it { is_expected.to validate_presence_of(:title) }
  end
end
