# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160324195538) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "activities", ["event_id"], name: "index_activities_on_event_id"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "events", force: :cascade do |t|
    t.text     "desc"
    t.date     "date"
    t.time     "time"
    t.integer  "dow"
    t.string   "location"
    t.integer  "sport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "events", ["sport_id"], name: "index_events_on_sport_id"

  create_table "sports", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_prefs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sport_id"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_prefs", ["sport_id"], name: "index_user_prefs_on_sport_id"
  add_index "user_prefs", ["user_id"], name: "index_user_prefs_on_user_id"

  create_table "user_sports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sport_id"
    t.integer  "skill"
    t.integer  "games"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_sports", ["sport_id"], name: "index_user_sports_on_sport_id"
  add_index "user_sports", ["user_id"], name: "index_user_sports_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.string   "avatar"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
