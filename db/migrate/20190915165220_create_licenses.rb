class CreateLicenses < ActiveRecord::Migration[6.0]
  def change
    create_table :licenses do |t|
      t.references :client, null: false, foreign_key: true
      t.references :licensable, polymorphic: true
      t.integer :amount, null: false, default: 1
      t.date :expires_at
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :licenses, :discarded_at
  end
end
