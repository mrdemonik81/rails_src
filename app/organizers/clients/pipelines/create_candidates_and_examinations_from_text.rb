# frozen_string_literal: true

module Clients
  module Pipelines
    class CreateCandidatesAndExaminationsFromText
      include Micro::Service::Pipeline::Safe

      pipeline Candidates::Commands::CreateCandidatesFromText,
               Candidates::Commands::AddCandidatesToClient,
               Examinations::Commands::CreateForClientCandidates
    end
  end
end
