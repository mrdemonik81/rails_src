# frozen_string_literal: true

class ArrangeWordService
  def initialize(params)
    @task = params[:task]
    @expected = params[:expected]
    @answer = params[:answer]
  end

  def evaluate
    expected_words = @expected.split(' ')
    answer_words = @answer.split(' ')
    count = calculate_matching_result(expected_words, answer_words)

    if @task.true_false?
      count / expected_words.length
    elsif @task.fractional?
      count / expected_words.length.to_f
    else
      0
    end
  end

  def calculate_matching_result(expected_words, answer_words)
    count = 0
    expected_words.each_with_index do |word, index|
      break if word != answer_words[index]

      count += 1
    end
    count
  end
end
