##The whole bundles needed in Sign-in

require 'bundle/setup'
require 'rack/cors'
require 'grape'
require 'grape_logging'
require 'json'
require 'rest-client'
require 'active_record'
require 'otr/activerecord'
require 'grape-swagger'
require 'grape-entity'
require './config/settings

OTR::ActiveRecord.configure_from_file! 'config/database.yml'
ActiveRecord::Base.default_timezone = :local
