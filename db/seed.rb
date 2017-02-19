test = Activities.new( date_end:1466735533808 ,date_start:1466735533808 ,creator_id:105502047 ,name:'a test activity' )
test.save!

Signs.create!( activity_id: test.activity_id,user_id:105502047 )
