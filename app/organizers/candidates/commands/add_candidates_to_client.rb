# frozen_string_literal: true

module Candidates
  module Commands
    class AddCandidatesToClient < Micro::Service::Strict
      attributes :candidates, :client_id

      def call!
        client = Client.find(client_id)
        existing_client_candidates = client.client_candidates.where(candidate_id: candidates.map(&:id)).to_a
        existing_candidate_ids = existing_client_candidates.pluck(:candidate_id)
        client_candidates = client.client_candidates.create!(candidates.map do |c|
          { candidate_id: c.id } unless existing_candidate_ids.include?(c.id)
        end.compact)
        Success(client_candidates: client_candidates + existing_client_candidates)
      end
    end
  end
end
