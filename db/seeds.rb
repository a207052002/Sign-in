require './app/models/activity'
require './app/models/sign'

for i in (0..4)
  test = DB::Activity.new(date_start: 1466735533808+i ,date_end: 1466935533808+i, creator_id: (105502047+i).to_s, name:'a test activity')
  test.save!
  DB::Activity.create!(date_start: 1466735533808+i, date_end: 1466935531009, creator_id: (105502047).to_s, name: 'many tests')
  for j in (0..8)
    test.signs.create( user_id: (105502047+i).to_s )
    test.signs
  end
end
