# frozen_string_literal: true

module Examinations
  module Commands
    class CreateForClientCandidates < Micro::Service::Strict
      attributes :client_candidates, :exam_id, :expires_at

      def call!
        exam = Exam.find(exam_id)
        existing_examinations = exam.examinations.where(client_candidate_id: client_candidates.map(&:id)).to_a
        existing_cc_ids = existing_examinations.pluck(:client_candidate_id)
        examinations = exam.examinations.create!(client_candidates.map do |client_candidate|
          { client_candidate_id: client_candidate.id } unless existing_cc_ids.include?(client_candidate.id)
        end.compact)
        Success(examinations: examinations)
      end
    end
  end
end
