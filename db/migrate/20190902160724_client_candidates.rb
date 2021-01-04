class ClientCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :client_candidates do |t|
      t.references :client, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
