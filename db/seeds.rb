test = activities.new(date_start: 1466735533808 ,date_end: 1466935533808, creator_id:105502047, name:'a test activity')
test.save!

signs.create!(activity_id: test.id, user_id: 105502047)
