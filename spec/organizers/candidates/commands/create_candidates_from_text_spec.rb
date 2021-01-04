# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::Commands::CreateCandidatesFromText do
  describe '.call' do
    let(:candidate_data) do
      <<EXCEL_DATA
        fname\tlname\temail\tmobile
        candidate A\tcandidate A\tcandidate1@test.com\t992 000 001
        candidate B\tcandidate B\tcandidate2@test.com\t992 000 002
EXCEL_DATA
    end

    context 'with valid rows' do
      it 'creates bulk Candidates from text' do
        expect { described_class.call(text: candidate_data) }.to change(Candidate, :count).by(2)
      end
    end

    context 'with duplicated emails' do
      before do
        create(:candidate, email: 'candidate1@test.com')
      end

      it 'skips duplicated emails' do
        expect { described_class.call(text: candidate_data) }.to change(Candidate, :count).by(1)
      end
    end
  end
end
