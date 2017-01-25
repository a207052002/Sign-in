require 'bundle/setup'
require 'rack/cors'
require 'grape'
require 'grape_logging'
require 'json'
require 'rest-client'
require 'active_record'
require 'grape/activerecord'
require 'grape-swagger'
require 'grape-entity'
require './config/settings

OTR::ActiveRecord.configure_from_file! 'config/database.yml'

