module DB
  class Sign < ActiveRecord::Base
    belongs_to :activity
  end
end
