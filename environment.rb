##The whole bundles needed in Sign-in

require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'grape'
require 'json'
require 'rest-client'
require 'active_record'
require 'grape-entity'
require './config/settings'

OTR::ActiveRecord.configure_from_file! 'config/database.yml'
ActiveRecord::Base.default_timezone = :local
