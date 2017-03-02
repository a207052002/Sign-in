##The whole bundles needed in Sign-in
require 'bundler/setup'
require 'kaminari'
require 'grape'
require 'json'
require 'rest-client'
require 'otr-activerecord'
require 'active_record'
require 'grape-entity'
require './config/settings'
OTR::ActiveRecord.configure_from_file! 'config/database.yml'
ActiveRecord::Base.default_timezone = :local

class Integer
  def to_t
    time.at(self/1000)
  end
end
