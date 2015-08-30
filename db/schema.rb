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

ActiveRecord::Schema.define(version: 20150830141438) do

  create_table "picks", force: true do |t|
    t.integer  "team_id",    null: false
    t.integer  "player_id",  null: false
    t.integer  "round",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "picks", ["player_id"], name: "index_picks_on_player_id", unique: true, using: :btree
  add_index "picks", ["team_id", "round"], name: "index_picks_on_team_id_and_round", unique: true, using: :btree

  create_table "players", force: true do |t|
    t.string   "name",            null: false
    t.string   "position",        null: false
    t.string   "team"
    t.integer  "total_rank",      null: false
    t.integer  "positional_rank", null: false
    t.integer  "bye_week"
    t.integer  "picked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_position", null: false
  end

end
