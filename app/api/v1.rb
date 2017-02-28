module Signin

  def itime(t)
    Time.at(t/1000)
  end

  class V1 < Grape::API
    class << self
      include Activity::V1
      include Sign::V1
    end

    format :json
    content_type :json
    helpers HTTP::Error::Helpers
    helpers NCU::OAuth::Helpers
    helpers do
    def request
      @request||=::Rack::Request.new(env)
    end
    load_activity
    load_sign
  end
end
