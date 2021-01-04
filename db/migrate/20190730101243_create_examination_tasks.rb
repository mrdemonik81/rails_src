class CreateExaminationTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :examination_tasks do |t|
      t.references :examination, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :score
      t.integer :time_spent
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
