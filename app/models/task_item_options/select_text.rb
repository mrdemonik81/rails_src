# frozen_string_literal: true

# == Schema Information
#
# Table name: task_item_options
#
#  id           :bigint           not null, primary key
#  task_item_id :bigint
#  correct      :boolean
#  text_option  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  context      :jsonb            not null
#

class TaskItemOptions::SelectText < ::TaskItemOption
  belongs_to :item,
             class_name: 'TaskItems::SelectText',
             foreign_key: :task_item_id,
             inverse_of: :options
  store_accessor :context, :answer
end
