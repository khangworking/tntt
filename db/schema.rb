# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_07_141950) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sort_order"
  end

  create_table "managers", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "level_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_managers_on_level_id"
    t.index ["person_id"], name: "index_managers_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "fullname"
    t.string "christain_name"
    t.string "phone"
    t.date "birthday"
    t.date "feastday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender", default: "male"
    t.bigint "level_id"
    t.boolean "active", default: true
    t.string "role"
    t.bigint "user_id"
    t.text "address"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "people_presences", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "level_id"
    t.text "person_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.index ["level_id"], name: "index_people_presences_on_level_id"
    t.index ["user_id"], name: "index_people_presences_on_user_id"
  end

  create_table "people_relationships", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "child_id"
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "score_cells", force: :cascade do |t|
    t.bigint "score_id"
    t.bigint "person_id"
    t.float "score_in_number"
    t.date "applied_date"
    t.bigint "modified_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "score_type"
    t.index ["person_id"], name: "index_score_cells_on_person_id"
    t.index ["score_id"], name: "index_score_cells_on_score_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "level_id"
    t.date "start_date"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_scores_on_level_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "options"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
