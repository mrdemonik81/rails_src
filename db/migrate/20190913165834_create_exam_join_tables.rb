class CreateExamJoinTables < ActiveRecord::Migration[6.0]
  def change
    create_table :exam_skills do |t|
      t.bigint :exam_id
      t.bigint :skill_id
    end
    add_index :exam_skills, :exam_id
    add_index :exam_skills, :skill_id

    create_table :exam_domains do |t|
      t.bigint :exam_id
      t.bigint :domain_id
    end
    add_index :exam_domains, :domain_id
    add_index :exam_domains, :exam_id

    create_table :exam_levels do |t|
      t.bigint :exam_id
      t.bigint :level_id
    end
    add_index :exam_levels, :exam_id
    add_index :exam_levels, :level_id
  end
end
