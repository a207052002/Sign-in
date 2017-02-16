module DB
    class Activity < ActiveRecord::Base
        has_many :signs
    end
end
