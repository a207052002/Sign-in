module Signin
    class v1 < Grape::API

        class << self
            include Namespace::v1
            include Signin::v1
        end

        format :json
        content_type :json

#        helpers HTTP::Error::Helpers
#        helpers NCU::OAuth::Helpers
#        helpers do              unknow
#            def request
#                @request ||= ::Rack::Request.new(env)
#            end
    end
end
