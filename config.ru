require File.expand_path('./environment',_FILE_)
use ActiveRecord::ConnectionAdapters::ConnectionManagement
require File.expand_path('./app',_FILE_)

run Signin::API
