require './environment'
require File.expand_path('../app',__FILE__)


use OTR::ActiveRecord::ConnectionManagement

use Rack::Cors do
   allow do
     origins '*'
     resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
   end
end

run Signin::API
