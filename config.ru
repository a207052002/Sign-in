require File.expand_path('../app',__FILE__)
require '../environment'

use OTR::ActiveRecord::ConnectionManagement
run Signin::API
