class AddDiscardToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :discarded_at, :datetime
    add_index :clients, :discarded_at
    add_column :client_users, :discarded_at, :datetime
    add_index :client_users, :discarded_at
    add_column :client_candidates, :discarded_at, :datetime
    add_index :client_candidates, :discarded_at
  end
end
