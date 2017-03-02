require './environment'
require File.expand_path('../app',__FILE__)

ENV['RACK_ENV'] = 'test'

use OTR::ActiveRecord::ConnectionManagement
run Signin::API
