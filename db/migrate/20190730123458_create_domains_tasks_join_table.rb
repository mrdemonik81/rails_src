class CreateDomainsTasksJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :domains_tasks, id: false do |t|
      t.bigint :domain_id
      t.bigint :task_id
    end

    add_index :domains_tasks, :domain_id
    add_index :domains_tasks, :task_id
  end
end
