# frozen_string_literal: true

require 'csv'

module Candidates
  module Commands
    class CreateCandidatesFromText < Micro::Service::Strict
      attribute :text

      def call!
        hash_array = CSV.new(text, col_sep: "\t", headers: true, header_converters: :symbol,
                                   skip_blanks: true, converters: :all).to_a.map(&:to_h)
        existing_candidates = Candidate.where(email: hash_array.map { |h| h[:email] }).to_a
        duplicated_emails = existing_candidates.pluck(:email)
        candidates = Candidate.create!(hash_array.reject { |h| duplicated_emails.include?(h[:email]) })
        Success(candidates: candidates + existing_candidates)
      end
    end
  end
end
