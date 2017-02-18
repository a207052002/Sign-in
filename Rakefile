require 'bundle/setup'
require 'otr/activerecord/rake'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'date'
OTR::ActiveRecord.seed_file = './db/seeds.rb'

load 'tasks/otr-activerecord.rake'

Rspec::Core::RakeTask.new(:spec)

namespace :db do
  task :enviroment do
    require './environment'
    require_relative 'app'
  end
end

def itime(t)
  Time.at(t).to_datetime
end

namespace :ns do
  task :insert, [:name, :uid, :end, :start] do |t, args|
    require './environment'
    require './app/models/activity'
    DB::Activities.creat(name:args.name, date_end: itime(args.end), date_start: itime(args.start), created_at:DateTime.now, creator_id: args.uid)
  end
end

task :default do
  ENV['RACK_ENV'] = 'test'
  require './environment'
  require './app'
  Rake::Task['db:reset'].invoke
  Rake::Task['spec'].invoke
end
