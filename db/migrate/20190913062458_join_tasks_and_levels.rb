class JoinTasksAndLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels_tasks, id: false do |t|
      t.belongs_to :level
      t.belongs_to :task
    end
  end
end
