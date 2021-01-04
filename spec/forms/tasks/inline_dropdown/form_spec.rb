# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::InlineDropdown::Form, type: :model do
  let!(:inline_dropdown) { build_stubbed(:inline_dropdown) }
  let(:valid_params) do
    {
      task: inline_dropdown,
      title: 'test title',
      audio: fixture_file_upload('files/audio.mp3', 'audio/mp3', true)
    }
  end

  let(:invalid_params) do
    {
      task: inline_dropdown,
      audio: fixture_file_upload('files/document.pdf', 'application/pdf', true)
    }
  end

  describe '#persist!' do
    context 'when InlineDropdownTask form valid' do
      subject(:task_form) { described_class.new(valid_params) }

      it { expect(task_form.valid?).to eq(true) }
    end

    context 'when InlineDropdownTask form invalid' do
      subject(:task_form) { described_class.new(invalid_params) }

      it { expect(task_form.valid?).to eq(false) }
    end
  end
end
