ActiveRecord::Schema.define(version:2017) do
  create_table "activities" , force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date_end", null: false
    t.datetime "date_start", null: false
    t.integer "creator_id", null: false
    t.string "name", null: false
  end

  create_table "signs" , force: :cascade do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.index([:activity_id], name:"index_signs_on_activity_id")
  end
end
