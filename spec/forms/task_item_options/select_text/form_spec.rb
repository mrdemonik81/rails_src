# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskItemOptions::SelectText::Form, type: :model do
  let(:valid_params) { { answer: 'Title', correct: true } }
  let(:invalid_params) { valid_params.merge(answer: nil) }

  describe 'Model validations' do
    context 'when valid params' do
      subject { described_class.new(valid_params) }

      it { is_expected.to be_valid }
    end

    context 'when invalid params' do
      subject { described_class.new(invalid_params) }

      it { is_expected.to be_invalid }
    end
  end
end
