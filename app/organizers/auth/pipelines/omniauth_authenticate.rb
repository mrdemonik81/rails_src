# frozen_string_literal: true

module Auth
  module Pipelines
    class OmniauthAuthenticate
      include Micro::Service::Pipeline

      pipeline Auth::Commands::UserFromOmniauth # , EnsureInitialTeam
    end
  end
end
