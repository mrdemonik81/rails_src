class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name
      t.boolean :published, default: false
      t.integer :max_time
      t.integer :max_tasks
      t.decimal :price, precision: 6, scale: 2
      t.integer :algorithm, default: 0
      t.integer :result_type, default: 0
      t.text :task_types, array: true, default: []
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
