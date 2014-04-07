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

ActiveRecord::Schema.define(version: 20140407070801) do

  create_table "achievements", force: true do |t|
    t.integer  "user_id",                  null: false
    t.integer  "challenge_id",             null: false
    t.integer  "year",                     null: false
    t.integer  "month",                    null: false
    t.integer  "date",                     null: false
    t.integer  "time",                     null: false
    t.integer  "star",         default: 0, null: false
    t.integer  "medal",        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: true do |t|
    t.integer  "group",         null: false
    t.integer  "level",         null: false
    t.integer  "stage",         null: false
    t.integer  "rank",          null: false
    t.string   "caption"
    t.string   "description"
    t.string   "description_1"
    t.string   "description_2"
    t.string   "description_3"
    t.string   "description_4"
    t.string   "comment"
    t.string   "category"
    t.integer  "param_0"
    t.integer  "param_1"
    t.integer  "param_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["group", "level"], name: "index_challenges_on_group_and_level", unique: true

  create_table "counsel_comments", force: true do |t|
    t.integer  "counsel_id"
    t.integer  "user_id"
    t.integer  "time"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counsels", force: true do |t|
    t.string   "title"
    t.string   "work"
    t.string   "meal"
    t.string   "exercise"
    t.string   "snack"
    t.string   "drink"
    t.string   "illnesses"
    t.string   "byProfile"
    t.string   "byCustom"
    t.string   "byAction"
    t.string   "byIllness"
    t.string   "recommendedChallenges"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rankings", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "year",            null: false
    t.integer  "month",           null: false
    t.integer  "date",            null: false
    t.integer  "time",            null: false
    t.float    "bmi"
    t.float    "loss_rate"
    t.integer  "star_count"
    t.integer  "bmi_rank"
    t.integer  "loss_rate_rank"
    t.integer  "star_count_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",              null: false
    t.string   "password",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "gender"
    t.string   "birthday"
    t.string   "occupation"
    t.string   "exercising_custom"
    t.string   "meal_custom"
    t.string   "purpose"
    t.float    "height"
    t.float    "initial_weight"
    t.float    "target_weight"
    t.float    "current_weight"
    t.integer  "last_measure"
    t.float    "loss_rate"
    t.float    "current_bmi"
    t.integer  "ticket_count"
    t.integer  "star_count"
    t.integer  "medal_count"
    t.integer  "group_0"
    t.integer  "level_0"
    t.integer  "group_1"
    t.integer  "level_1"
    t.integer  "group_2"
    t.integer  "level_2"
  end

  create_table "weights", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "year",       null: false
    t.integer  "month",      null: false
    t.integer  "date",       null: false
    t.integer  "time",       null: false
    t.float    "weight"
    t.float    "rate"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
