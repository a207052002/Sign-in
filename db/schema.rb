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

ActiveRecord::Schema.define(version: 2017) do

  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date_end",   null: false
    t.datetime "date_start", null: false
    t.integer  "creator_id", null: false
    t.string   "name",       null: false
  end

  create_table "signs", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.index ["activity_id"], name: "index_signs_on_activity_id"
  end

end
