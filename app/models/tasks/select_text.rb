# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id               :bigint           not null, primary key
#  name             :string
#  type             :string           not null
#  instruction      :text
#  introduction     :text
#  complexity       :integer          default("low")
#  performance      :float
#  ordered_solution :boolean          default(FALSE)
#  manual_check     :boolean          default(FALSE)
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string           default(""), not null
#  context          :jsonb            not null
#  published        :boolean          default(FALSE), not null
#  score_method     :integer          default("true_false"), not null
#

module Tasks
  class SelectText < ::Task
    include BaseType
    has_many :items,
             class_name: 'TaskItems::SelectText',
             foreign_key: :task_id,
             dependent: :destroy,
             inverse_of: :task
    has_one_attached :audio
  end
end
