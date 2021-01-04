# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskItemOptions::SelectImage::Form, type: :model do
  let(:valid_params) do
    {}
  end

  describe 'Model validations' do
    context 'when valid params' do
      subject { described_class.new(valid_params) }

      it { is_expected.to be_valid }
    end
  end
end
