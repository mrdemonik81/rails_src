class RenameCandidateColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :candidates, :first_name, :fname
    rename_column :candidates, :last_name, :lname
    add_column :candidates, :gender, :integer, null: false, default: 0
    add_column :candidates, :ssn, :string, null: false, default: ''
  end
end
