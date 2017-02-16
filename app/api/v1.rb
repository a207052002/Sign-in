module Signin
    class V1 < Grape::API

        class << self
            include Activity::v1
            include Sign::v1
        end

        format :json
        content_type :json

#        helpers HTTP::Error::Helpers
#        helpers NCU::OAuth::Helpers
#        helpers do              unknow
#            def request
#                @request ||= ::Rack::Request.new(env)
#            end
        load_activity
        load_sign
    end
end
