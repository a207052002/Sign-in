require './app/models/activity'
require './app/models/sign'

for i in (0..2)
  test = DB::Activity.new(date_start: 1466735533808+i ,date_end: 1466935533808+i, creator_id:105502047+i, name:'a test activity')
  test.save!
  for j in (0..1)
    test.signs.create( user_id: 105502047+i+j )
    test.signs
  end
end
