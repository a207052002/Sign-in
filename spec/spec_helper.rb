ENV['RACK_ENV']||='test'
$no_log = true

require 'airborne'
require 'spec_helper'
require './environment'
require './app'
require './spec/spec_data'
require 'webmock/rspec'
stub_request(:get, "https://apitest.cc.ncu.edu.tw:5566/oauth/token/info").with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer de81f2f1c2dc069b7747556b8cf3fe66daeb82930f26439573b232e878e4a3b2', 'User-Agent'=>'Ruby'}).to_return(:status => 200, :body => "resource_owner_id: 105502047")

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

Airborne.configure do |config|
  config.rack_app = Signin::API
end

describe 'Signin::API' do

  base_url = '/signin/v1'

  #supposed to be token
  #
  #

  context 'activities' do
    context 'POST' do
      context 'add new activities' do
        it 'return id, name, date, userid' do
          post base_url + '/activities' ,{name:"Test_Activity", dateStarted:1466735533808, dateEnded:1466735533808}, {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}" }
          expect_status 201
          expect_json(name:'Test_Activity',dateStarted:1466735533000,dateEnded:1466735533000)
        end
      end
      context 'Sign in activities' do
        it 'return userid, signing date' do
          test_time = Time.now
          post base_url + '/activities/1/sign_in',{userId: '105502047'}
          expect_json(userId: '105502047', dateCreated: test_time.to_i * 1000)
          expect_status 201
        end
      end
    end
    context 'GET' do
      context 'Get the form of activities' do
        it 'return userid and created date , data of pages' do
          get base_url + '/activities',{page: 1, size: 1}
          expect_status(200)
          expect_json(content:[{userid: '105502047', dateCreated: 1466735533000}] , pageMetadata: {size: 1, totalElements: 1, totalPages: 1,number: 0})
        end
      end
      context 'Get the information of activities' do
        it 'return the whole information' do
          get base_url + '/activities/1', {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(200)
          expect_json(id: 1, name: 'a_test_activity', dateStarted: 1466735533000, dateEnded: 1466935533000, dateCreated: 146673530400, creatorid: 105502047)
        end
      end
      context 'Get self activities' do
        it 'return activities of user' do
          get base_url + '/activities' ,{page: 1,size: 1}, {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          except_json(content:[{id:1, name:'NAME', dateStarted:1466735533000, dateEnded: 1466935533000, dateCreated: 146673471600, creatorid:105502047}], pageMetadata: {size:1, totalElements:1, totalPages:1, number:0})
        end
      end
    end
    context 'PUT' do
      context 'edit activities' do
        it 'return whole information of activities' do
          put base_url + '/activities', {name: 'changing_NAME', dateStarted: 1466734716596, dateEnded: 1466734716596}
          expect_status(201)
          expect_json(id: 666, name: 'changing_NAME', dateStarted: 146673416000, dateEnded: 146673416000, dateCreated: 146673530400, creatorid: 105502047)
        end
      end
    end
    context 'DEL' do
      context 'delet activities' do
        it 'return 204 http code' do
          delete base_url + '/activities/2'
          expect_status(204)
        end
      end
    end
  end
end
