# frozen_string_literal: true

# == Schema Information
#
# Table name: examination_tasks
#
#  id             :bigint           not null, primary key
#  examination_id :bigint
#  task_id        :bigint
#  score          :integer
#  time_spent     :integer
#  discarded_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :examination_task do
    examination { nil }
    task { nil }
    score { 1 }
    time_spent { 1 }
    discarded_at { '2019-07-30 11:57:30' }
  end
end
