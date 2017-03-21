##The whole bundles needed in Sign-in
require 'bundler/setup'
require 'kaminari'
require 'grape'
require 'json'
require 'rest-client'
require 'otr-activerecord'
require 'active_record'
require 'grape-entity'
require 'rack/cors'

require './config/settings'
OTR::ActiveRecord.configure_from_file! '/home/a207052002/Sign-in/config/database.yml'
ActiveRecord::Base.default_timezone = :local

class Integer
  def to_t
    Time.at(self/1000)
  end
end
