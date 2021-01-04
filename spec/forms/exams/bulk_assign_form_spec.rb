# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exams::BulkAssignForm, type: :model do
  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:client_id) }
    it { is_expected.to validate_presence_of(:candidates) }
    it { is_expected.to validate_presence_of(:expires_at) }
  end
end
