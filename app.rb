require './app/models/activity'
require './app/models/sign'
require './app/view/entities'
require './app/api/v1/activity'
require './app/api/v1/sign'
require './app/helpers/error_helpers'
require './app/helpers/oauth'
require './app/api/v1'

module Signin
  class API < Grape::API
    mount V1 => '/signin/v1'
  end
end
