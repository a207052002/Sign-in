require 'bundler/setup'
require 'rspec/core'
require 'rspec/core/rake_task'

load 'tasks/otr-activerecord.rake'

RSpec::Core::RakeTask.new(:spec)

namespace :db do
    ENV['RACK_ENV'] ||= 'test'
  task :environment do
    require './environment'
  end
end

def itime(t)
    Time.at(t.to_i)
end

namespace :activity do
    task :insert, [:name, :uid, :start, :end] do |t, args|
    require './environment'
    require './app/models/activity'
    DB::Activity.create(name:args.name, date_end: itime(args.end), date_start: itime(args.start), creator_id: args.uid)
  end
end

task :default do
  ENV['RACK_ENV'] ||= 'test'
  require './environment'
  require './app'
  Rake::Task['db:reset'].invoke
  Rake::Task['spec'].invoke
end
