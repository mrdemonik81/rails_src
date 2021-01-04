# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::TrueFalse::Form, type: :model do
  let(:task) { build_stubbed(:true_false) }
  let(:valid_params) do
    {
      task: task,
      title: 'Statements for you',
      introduction: 'Introduction',
      instruction: 'Instructions'
    }
  end
  let(:invalid_params) { valid_params.merge(introduction: nil) }

  describe '#persist!' do
    context 'when TrueFalseTask form valid' do
      subject(:task_form) { described_class.new(valid_params) }

      it { is_expected.to be_valid }
    end

    context 'when TrueFalseTask form invalid' do
      subject(:task_form) { described_class.new(invalid_params) }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'Model validations' do
    subject { described_class.new(task: Task.new) }

    it { is_expected.to validate_presence_of(:introduction) }
    it { is_expected.to validate_presence_of(:title) }
  end
end
