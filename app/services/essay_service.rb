# frozen_string_literal: true

class EssayService
  def initialize(params)
    @task = params[:task]
    @expected = params[:expected]
    @answer = params[:answer]
  end

  def evaluate
    true
  end
end
