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

ActiveRecord::Schema.define(version: 20160804023031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "quest_id"
    t.decimal  "distance",   precision: 5, scale: 2
    t.time     "start_time"
    t.integer  "calories"
    t.string   "status"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.time     "end_time"
    t.decimal  "avg_pace",   precision: 4, scale: 2
  end

  create_table "clan_quests", force: :cascade do |t|
    t.integer  "clan_id"
    t.integer  "quest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clans", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.string   "quest_type"
    t.date     "deadline"
    t.integer  "assigner_id"
    t.integer  "assignee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.integer  "clan_id"
    t.boolean  "lord"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "char_name"
  end

end
