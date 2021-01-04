# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'expect and answer' do |expected, answer, result_fractional, result_non_fractional|
  describe 'expect and answer' do
    let(:fractional_params) do
      {
        title: 'Statements for you',
        introduction: 'Introduction',
        instruction: 'Instructions',
        score_method: Task.score_methods[:fractional]
      }
    end
    let(:non_fractional_params) { fractional_params.merge(score_method: Task.score_methods[:true_false]) }
    let(:fractional_form) do
      Task.new(fractional_params)
    end
    let(:non_fractional_form) do
      Task.new(non_fractional_params)
    end

    context 'with fractional params' do
      subject(:arrange_words_service) { described_class.new(task: fractional_form, expected: expected, answer: answer) }

      it { expect(arrange_words_service.evaluate).to eq(result_fractional) }
    end

    context 'with non fractional params' do
      subject(:arrange_words_service) { described_class.new(task: non_fractional_form, expected: expected, answer: answer) }

      it { expect(arrange_words_service.evaluate).to eq(result_non_fractional) }
    end
  end
end

RSpec.describe MarkWordService, type: :service do
  it_behaves_like 'expect and answer',
                  'This is a *big* problem for a *big* world.',
                  'This is a *big* problem for a big world',
                  0.5,
                  0
end
