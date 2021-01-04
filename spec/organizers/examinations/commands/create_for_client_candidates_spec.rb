# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Examinations::Commands::CreateForClientCandidates do
  let(:exam) { create(:exam) }
  let(:client_candidates) { create_list(:client_candidate, 3) }

  describe '.call' do
    it 'creates examination for each client_candidate' do
      expect do
        described_class.call(client_candidates: client_candidates, exam_id: exam.id, expires_at: '2019-09-13')
      end.to change(Examination, :count).by(3)
    end

    context 'when a client_candidate has already the same examination' do
      before do
        client_candidates[0].examinations.create!(exam: exam)
      end

      it 'skips existing client_candidates' do
        expect do
          described_class.call(client_candidates: client_candidates, exam_id: exam.id, expires_at: '2019-09-13')
        end.to change(Examination, :count).by(2)
      end
    end
  end
end
