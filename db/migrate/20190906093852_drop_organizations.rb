class DropOrganizations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :examinations, :organisation, index: true, foreign_key: true
    add_reference :examinations, :client, index: true, foreign_key: true
    add_reference :examinations, :user, index: true, foreign_key: true
    drop_table :organisations, {}
  end
end
