require 'bundler/setup'
require 'rspec/core'
require 'rspec/core/rake_task'
require './environment.rb'
require './app'

load 'tasks/otr-activerecord.rake'

RSpec::Core::RakeTask.new(:spec)
ENV['RACK_ENV']||='test'

namespace :db do
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
  task :destroy, [:id] do |t, args|
    require './environment'
    require './app/models/activity'
    require './app/models/sign'
    DB::Activity.find_by_id(args.id).destroy
  end
  task :auth , [:token] do |t, args|
    require './environment'
    require './app/models/activity'
    require './app/models/sign'
    RestClient::Request.execute verify_ssl: false, method: :get, url: Settings::OAUTH_ACCESS_TOKEN_URL, headers:{authorization: "Bearer #{args.token}"} do |response, request, result, &block|
      res = JSON.parse(response.body,symbolize_names: true) 
      puts 'Not Found!' if res.nil?
      puts "Found id:#{res[:resource_owner_id]}"
      puts "Expires:#{res[:expires_in_seconds]}"
    end
  end
end

task :default do
  ENV['RACK_ENV'] ||= 'test'
  require './environment'
  require './app'
  Rake::Task['db:reset'].invoke
  Rake::Task['spec'].invoke
end
