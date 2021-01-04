# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::Commands::AddCandidatesToClient do
  let(:client) { create(:client) }
  let(:candidates) { create_list(:candidate, 3) }

  describe '.call' do
    it 'creates ClientCandidates for a Client' do
      expect { described_class.call(client_id: client.id, candidates: candidates) }.to change(ClientCandidate, :count).by(3)
    end

    context 'when a candidate is already in the client' do
      before do
        client.client_candidates.create!(candidate: candidates[0])
      end

      it 'skips existing candidates' do
        expect { described_class.call(client_id: client.id, candidates: candidates) }.to change(ClientCandidate, :count).by(2)
      end
    end
  end
end
