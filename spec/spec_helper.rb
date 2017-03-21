$no_log = true

require 'airborne'
require 'spec_helper'
require './environment'
require './app'
require './spec/spec_data'
require 'webmock/rspec'
ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

Airborne.configure do |config|
  config.rack_app = Signin::API
end



describe 'Signin::API' do

  base_url = '/signin/v1'

  before(:each) do
    stub_request(:get, "https://apitest.cc.ncu.edu.tw:5566/oauth/token/info").with(headers: {'Authorization'=>'Bearer de81f2f1c2dc069b7747556b8cf3fe66daeb82930f26439573b232e878e4a3b2'}).to_return(:status => 200, :body => '{"resource_owner_id": "105502047"}')
  end
  #supposed to be token
  #
  #

  context 'activities' do
    context 'POST' do
      context 'add new activities' do
        it 'return id, name, date, userid' do
          post base_url + '/activities' ,{name:"Test_Activity", dateStarted:1466735533808, dateEnded:1466735533808}, {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}" }
          expect_status 201
          json_body.delete(:dateCreated)
          expect_json(name:'Test_Activity',dateStarted:1466735533000,dateEnded:1466735533000)
        end
      end
      context 'Sign in activities' do
        it 'return userid, signing date' do
          post base_url + '/activities/1/sign_in',{userId: '105502047'}, {'Authorization' => "Bearer #{TestData::BEARER_TOKEN}"}
          expect_status 201
          json_body.delete :dateCreated
          expect_json(userId: '105502047')
        end
      end
    end
    context 'GET' do
      context 'Get the form of activities' do
        it 'return userid and created date , data of pages' do
          get base_url + '/activities?page=1&size=1', {'Authorization' => "Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(200)
          json_body[:content].each { |activity| expect(activity.delete :dateCreated).to be_a(Integer); }
          expect_json(content:[{:id=>1, :name=>"a test activity", :dateStarted=>1466735533808000 ,:dateEnded=>1466935533808000, :creatorId=>"105502047"}] , pageMetadata: {size: 10, totalElements: 10, totalPages: 1,number: 0})
        end
      end
      context 'Get the information of activities' do
        it 'return the whole information' do
          get base_url + '/activities/1', {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(200)
          body.delete("dateCreated")
          expect_json(id: 1, name: 'a test activity', dateStarted: 1466735533808000, dateEnded: 1466935533808000, creatorId: '105502047')
        end
      end
      context 'Get self activities' do
        it 'return activities of user' do
          get base_url + '/activities?page=1&size=1', {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(200)
          json_body.delete :dateCreated
          expect_json(content:[{id:1, name:'a test activity', dateStarted:1466735533808000, dateEnded: 1466935533808000, creatorId: "105502047" }], pageMetadata: {size: 1, totalElements: 1, totalPages: 1, number:0})
        end
      end
    end
    context 'PUT' do
      context 'edit activities' do
        it 'return whole information of activities' do
          put base_url + '/activities/1', {name: 'changing_NAME', dateStarted: 1466734716596, dateEnded: 1466734716596}, {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(200)
          expect_json(id: 1, name: 'changing_NAME', dateStarted: 1466734716000, dateEnded: 1466734716000 , creatorId: "105502047")
        end
      end
    end
    context 'DEL' do
      context 'delet activities' do
        it 'return 204 http code' do
          delete base_url + '/activities/1', {}, {'Authorization'=>"Bearer #{TestData::BEARER_TOKEN}"}
          expect_status(204)
        end
      end
    end
  end
end
