# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_26_173253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "candidate_solutions", force: :cascade do |t|
    t.bigint "examination_task_id"
    t.jsonb "solution", default: {}, null: false
    t.jsonb "task_snapshot", default: {}, null: false
    t.boolean "correct", default: false
    t.integer "score"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_candidate_solutions_on_discarded_at"
    t.index ["examination_task_id"], name: "index_candidate_solutions_on_examination_task_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "mobile"
    t.string "locale"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gender", default: 0, null: false
    t.string "ssn", default: "", null: false
    t.index ["discarded_at"], name: "index_candidates_on_discarded_at"
    t.index ["email"], name: "index_candidates_on_email", unique: true
  end

  create_table "client_candidates", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["candidate_id"], name: "index_client_candidates_on_candidate_id"
    t.index ["client_id"], name: "index_client_candidates_on_client_id"
    t.index ["discarded_at"], name: "index_client_candidates_on_discarded_at"
  end

  create_table "client_users", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["client_id"], name: "index_client_users_on_client_id"
    t.index ["discarded_at"], name: "index_client_users_on_discarded_at"
    t.index ["user_id"], name: "index_client_users_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.text "billing_info"
    t.string "org_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_clients_on_discarded_at"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domains_tasks", id: false, force: :cascade do |t|
    t.bigint "domain_id"
    t.bigint "task_id"
    t.index ["domain_id"], name: "index_domains_tasks_on_domain_id"
    t.index ["task_id"], name: "index_domains_tasks_on_task_id"
  end

  create_table "exam_domains", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "domain_id"
    t.index ["domain_id"], name: "index_exam_domains_on_domain_id"
    t.index ["exam_id"], name: "index_exam_domains_on_exam_id"
  end

  create_table "exam_levels", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "level_id"
    t.index ["exam_id"], name: "index_exam_levels_on_exam_id"
    t.index ["level_id"], name: "index_exam_levels_on_level_id"
  end

  create_table "exam_skills", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "skill_id"
    t.index ["exam_id"], name: "index_exam_skills_on_exam_id"
    t.index ["skill_id"], name: "index_exam_skills_on_skill_id"
  end

  create_table "examination_tasks", force: :cascade do |t|
    t.bigint "examination_id"
    t.bigint "task_id"
    t.integer "score"
    t.integer "time_spent"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_examination_tasks_on_discarded_at"
    t.index ["examination_id"], name: "index_examination_tasks_on_examination_id"
    t.index ["task_id"], name: "index_examination_tasks_on_task_id"
  end

  create_table "examinations", force: :cascade do |t|
    t.bigint "exam_id"
    t.datetime "expires_at"
    t.integer "total_score", default: 0, null: false
    t.integer "total_time_spent", default: 0, null: false
    t.integer "status", default: 0
    t.jsonb "meta", default: {}, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "client_candidate_id"
    t.index ["client_candidate_id"], name: "index_examinations_on_client_candidate_id"
    t.index ["discarded_at"], name: "index_examinations_on_discarded_at"
    t.index ["exam_id"], name: "index_examinations_on_exam_id"
    t.index ["user_id"], name: "index_examinations_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.boolean "published", default: false
    t.integer "max_time"
    t.integer "max_tasks"
    t.decimal "price", precision: 6, scale: 2
    t.integer "algorithm", default: 0
    t.integer "result_type", default: 0
    t.text "task_types", default: [], array: true
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["discarded_at"], name: "index_exams_on_discarded_at"
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "levels_tasks", id: false, force: :cascade do |t|
    t.bigint "level_id"
    t.bigint "task_id"
    t.index ["level_id"], name: "index_levels_tasks_on_level_id"
    t.index ["task_id"], name: "index_levels_tasks_on_task_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "licensable_type"
    t.bigint "licensable_id"
    t.integer "amount", default: 1, null: false
    t.date "expires_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_licenses_on_client_id"
    t.index ["discarded_at"], name: "index_licenses_on_discarded_at"
    t.index ["licensable_type", "licensable_id"], name: "index_licenses_on_licensable_type_and_licensable_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_tasks", id: false, force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "task_id"
    t.index ["skill_id"], name: "index_skills_tasks_on_skill_id"
    t.index ["task_id"], name: "index_skills_tasks_on_task_id"
  end

  create_table "task_item_options", force: :cascade do |t|
    t.bigint "task_item_id"
    t.boolean "correct"
    t.string "text_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "context", default: {}, null: false
    t.index ["task_item_id"], name: "index_task_item_options_on_task_item_id"
  end

  create_table "task_items", force: :cascade do |t|
    t.bigint "task_id"
    t.string "type", null: false
    t.jsonb "context", default: {}, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.index ["discarded_at"], name: "index_task_items_on_discarded_at"
    t.index ["task_id"], name: "index_task_items_on_task_id"
    t.index ["type"], name: "index_task_items_on_type"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "type", null: false
    t.text "instruction"
    t.text "introduction"
    t.integer "complexity", default: 0
    t.float "performance"
    t.boolean "ordered_solution", default: false
    t.boolean "manual_check", default: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", default: "", null: false
    t.jsonb "context", default: {}, null: false
    t.boolean "published", default: false, null: false
    t.integer "score_method", default: 0, null: false
    t.index ["discarded_at"], name: "index_tasks_on_discarded_at"
    t.index ["type"], name: "index_tasks_on_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "mobile"
    t.string "locale"
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.jsonb "meta", default: {}, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.datetime "created_at"
    t.jsonb "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidate_solutions", "examination_tasks"
  add_foreign_key "client_candidates", "candidates"
  add_foreign_key "client_candidates", "clients"
  add_foreign_key "client_users", "clients"
  add_foreign_key "client_users", "users"
  add_foreign_key "examination_tasks", "examinations"
  add_foreign_key "examination_tasks", "tasks"
  add_foreign_key "examinations", "client_candidates"
  add_foreign_key "examinations", "exams"
  add_foreign_key "examinations", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "licenses", "clients"
  add_foreign_key "task_item_options", "task_items"
  add_foreign_key "task_items", "tasks"
end
