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

ActiveRecord::Schema.define(version: 2020_09_17_122656) do

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "permalink"
    t.string "name"
    t.string "email"
    t.string "new_email"
    t.boolean "is_certificated"
    t.boolean "is_premium"
    t.string "password_digest"
    t.string "description"
    t.string "url"
    t.string "location"
    t.datetime "birth"
    t.string "twitter_uid"
    t.string "twitter_url"
    t.string "github_uid"
    t.string "github_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

end
