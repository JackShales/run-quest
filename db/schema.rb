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

ActiveRecord::Schema.define(version: 20160907162059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "quest_id"
    t.integer  "calories"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "duration",   precision: 8, scale: 3
    t.decimal  "distance",   precision: 8, scale: 2
    t.datetime "start_time"
    t.integer  "user_id"
    t.string   "uri"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "status_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "action_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string   "name"
    t.integer  "status_code"
    t.string   "quest_type"
    t.date     "deadline"
    t.integer  "assigner_id"
    t.integer  "assignee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "notes"
  end

  create_table "user_quests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "experience"
    t.integer  "speed"
    t.integer  "endurance"
    t.integer  "mental"
    t.integer  "level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "char_name"
    t.string   "access_token"
    t.string   "token_type"
    t.string   "avatar"
  end

end
