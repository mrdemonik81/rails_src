class CreateOrganisations < ActiveRecord::Migration[5.2]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :registration_id
      t.string :address
      t.string :slug
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
