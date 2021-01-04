# frozen_string_literal: true

module Exams
  class BulkAssignForm < ApplicationForm
    attribute :client_id, Integer
    attribute :candidates, String
    attribute :expires_at, DateTime

    validates :client_id, presence: true
    validates :candidates, presence: true
    validates_format_of :candidates, with: /\n/, message: 'The format of candidates data is invalid'
    validates :expires_at, presence: true

    def save_to_exam(exam_id)
      result = Clients::Pipelines::CreateCandidatesAndExaminationsFromText.call(text: candidates, client_id: client_id,
                                                                                exam_id: exam_id, expires_at: expires_at)
      if result.success?
        true
      else
        errors.add(:candidates, result.value.message)
        false
      end
    end
  end
end
