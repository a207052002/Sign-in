ActiveRecord::Schema.define(version:2017) do
  create_table "activities" , force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date_end", null: false
    t.datetime "date_start", null: false
    t.string "creator_id", null: false
    t.string "name", null: false
  end

  create_table "signs" , force: :cascade do |t|
    t.string "activity_id", null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.index [:activity_id], name:"index_signs_on_activity_id"
  end
end
