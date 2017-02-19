require './app/models/activity'
require './app/models/sign'
require './app/view/entities'
require './app/api/v1'
require './app/api/v1/activity'
require './app/api/v1/sign'

module Signin
  class API < Grape::API
    mount V1 => '/Activity/V1'
  end
end
