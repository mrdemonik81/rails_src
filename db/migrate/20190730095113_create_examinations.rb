class CreateExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :examinations do |t|
      t.references :exam, foreign_key: true
      t.references :candidate, foreign_key: true
      t.references :organisation, foreign_key: true
      t.datetime :expires_at
      t.integer :total_score, null: false, default: 0
      t.integer :total_time_spent, null: false, default: 0
      t.integer :status, default: 0
      t.jsonb :meta, default: {}, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
