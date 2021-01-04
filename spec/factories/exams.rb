# frozen_string_literal: true

# == Schema Information
#
# Table name: exams
#
#  id           :bigint           not null, primary key
#  name         :string
#  published    :boolean          default(FALSE)
#  max_time     :integer
#  max_tasks    :integer
#  price        :decimal(6, 2)
#  algorithm    :integer          default("random")
#  result_type  :integer          default("minimal")
#  task_types   :text             default([]), is an Array
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#

FactoryBot.define do
  factory :exam do
    name { Faker::Educator.course }
    published { false }
    max_time { 1 }
    max_tasks { 1 }
    price { '9.99' }
    algorithm { 1 }
    result_type { 1 }
    task_types { 'MyText' }
  end
end
