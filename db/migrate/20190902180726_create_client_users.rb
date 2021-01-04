class CreateClientUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :client_users do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
