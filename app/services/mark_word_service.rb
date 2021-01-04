# frozen_string_literal: true

class MarkWordService
  def initialize(params)
    @task = params[:task]
    @expected = params[:expected]
    @answer = params[:answer]
  end

  def evaluate
    expected_words = extract_matching_words(@expected)
    answer_words = extract_matching_words(@answer)
    count = calculate_matching_result(expected_words, answer_words)

    if @task.true_false?
      count / expected_words.length
    elsif @task.fractional?
      count / expected_words.length.to_f
    else
      0
    end
  end

  def calculate_matching_result(correct, answer)
    [(correct && answer).size - (answer - correct).size, 0].max
  end

  def extract_matching_words(sentence)
    sentence.downcase
            .gsub(/[^\w\s*]+/, '')
            .split(' ')
            .each_with_index
            .select { |word, _i| word.match?(/^\*[^\*]+\*$/) }
            .map { |_w, i| i }
  end
end
