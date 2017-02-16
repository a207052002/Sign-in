ActiveRecord::Schema.define(version:2017) do
  creat_table "activities" , force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "date_end"
    t.datetime "date_start"
    t.integer "creator_id"
    t.string "name"
  end

  creat_table "signs" , force: :cascade do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.datetime "date_sign"
  end
  add_index "signs", ["activity_id"], name: "index_sign_on_activity"

end
