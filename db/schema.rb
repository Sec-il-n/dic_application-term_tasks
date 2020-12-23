# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_23_074139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "group_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_user_id", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "label_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "managers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "task_id"
    t.bigint "label_id"
    t.index ["label_id"], name: "index_managers_on_label_id"
    t.index ["task_id"], name: "index_managers_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.string "details", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "valid_date", null: false
    t.string "status", default: "", null: false
    t.integer "priority", default: 0
    t.bigint "user_id"
    t.index ["task_name"], name: "index_tasks_on_task_name"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "labels", "users"
  add_foreign_key "managers", "labels"
  add_foreign_key "managers", "tasks"
  add_foreign_key "tasks", "users"
end
