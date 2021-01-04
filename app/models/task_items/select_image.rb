# frozen_string_literal: true

# == Schema Information
#
# Table name: task_items
#
#  id           :bigint           not null, primary key
#  task_id      :bigint
#  type         :string           not null
#  context      :jsonb            not null
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  position     :integer          default(0), not null
#

class TaskItems::SelectImage < TaskItem
  has_many :options,
           class_name: 'TaskItemOptions::SelectImage',
           foreign_key: :task_item_id,
           inverse_of: :item,
           dependent: :destroy

  belongs_to :task,
             class_name: 'Tasks::SelectImage',
             inverse_of: :items
  store_accessor :context, :question
end
