# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::Pipelines::CreateCandidatesAndExaminationsFromText do
  let(:client) { create(:client) }
  let(:exam)   { create(:exam) }

  describe '.call' do
    it 'creates mass Candidates and Examinations for a Client' do
      candidates_data = <<EXCEL_DATA
        fname\tlname\temail\tmobile
        candidate A\tcandidate A\tcandidate1@test.com\t992 000 001
        candidate B\tcandidate B\tcandidate2@test.com\t992 000 002
EXCEL_DATA
      expect do
        described_class.call(text: candidates_data, client_id: client.id,
                             exam_id: exam.id, expires_at: '2019-09-14')
      end.to change(Candidate, :count)
        .by(2)
        .and change(ClientCandidate, :count)
        .by(2)
        .and change(Examination, :count)
        .by(2)
    end

    context 'when malformed text' do
      it 'returns Exception with message' do
        candidates_data = "unknown header\nwith malformed data"
        result = described_class.call(text: candidates_data, client_id: client.id,
                                      exam_id: exam.id, expires_at: '2019-09-14')
        expect(result).to be_failure
      end
    end
  end
end
