class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.string :name, null: false
      t.string :short_name, null: false

      t.timestamps
    end
  end
end
