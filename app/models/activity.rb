module DB
  class Activity < ActiveRecord::Base
    has_many :signs, dependent: :destroy
  end
end
