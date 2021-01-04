# frozen_string_literal: true

# == Schema Information
#
# Table name: candidate_solutions
#
#  id                  :bigint           not null, primary key
#  examination_task_id :bigint
#  solution            :jsonb            not null
#  task_snapshot       :jsonb            not null
#  correct             :boolean          default(FALSE)
#  score               :integer
#  discarded_at        :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :candidate_solution do
    examination_task { nil }
    solution { '' }
    task_snapshot { '' }
    correct { false }
    score { 1 }
    discarded_at { '2019-07-30 11:57:30' }
  end
end
