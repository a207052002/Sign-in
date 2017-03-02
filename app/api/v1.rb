module Signin
  class V1 < Grape::API
    class << self
      include Activity::V1
      include Sign::V1
    end

    format :json
    content_type :json
    helpers HTTP::Error::Helpers
    helpers NCU::OAuth::Helpers
    load_activity
    load_sign
  end
end
