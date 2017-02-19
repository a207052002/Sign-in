ENV['RACK_ENV']||='test'
$no_log = true

require 'airborne'
require 'spec_helper'
require './environment'
require './app'
require './spec/spec_data.rb'

RSpec.configure do |config|
    config.color = true
    config.formatter = :documentation
end

Airborne.configuration do |config|
   config.rack_app = Signin::API
   config.headers = {'X-forwarded-for' => '127.0.0.1'}
end

describe 'Signin::API' do

    base_url = '/activities/v1'

#supposed to be token
    #
    #

    context 'activities' do
        context 'POST' do
            context 'add new activities' do
                it 'return id, name, date, userid' do
                    post base_url ,{name:"Activity", dateStart:1466735533808, dateEnd:1466735533808}
                    expect_status 201
                    expect(json_body.delete)
                    expect_json(name:'Activity',dateStarted:1466735533808,dateEnd:1466735533808)
                end
            end
            context 'Sign in activities' do
                it 'return userid, signing date' do
                    post base_url + '/{activity_id}/sign_in',{userid: '105502047'}
                    expect_json(userid: '105502047', dateCreated: 1466735533808)
                    expect_status 201
                end
            end
        end
        context 'GET' do
            context 'Get the form of activities' do
                it 'return userid and created date , data of pages' do
                    get base_url + '/{activity_id}/sign_in',{'page' => '1', 'size' => 1}
                    expect_status(200)
                    expect_json(content:[{userid: '102502005', dateCreated: 1466735533000}] , pageMetadata: {size: 1, totalElements: 1, totalPages: 1,number: 0})
                end
            end
            context 'Get the information of activities' do
                it 'return the whole information' do
                    get base_url + '/{activity_id}'
                    expect_status(200)
                    expect_json(id: 666, name: 'NAME', dateStarted: 1466735533808, dateEnded: 1466735533808, dateCreated: 146673530400, creatorid: 105502047)
                end
            end
            context 'Get self activities' do
                it 'return activities of user' do
                    get base_url ,{'page' => '1','size' => 1}
                    except_json(content:[{id:666, name:'NAME', dateStarted:1466735533808, dateEnded: 1466735533808, dateCreated: 146673471600, creatorid:105502047}], pageMetadata: {size:1, totalElements:1, totalPages:1, number:0})
                end
            end
        end
        context 'PUT' do
            context 'edit activities' do
                it 'return whole information of activities' do
                    put base_url + '/{activity_id}', {name: 'changing NAME', dateStarted: 1466734716596, dateEnded: 1466734716596}
                    expect_status(201)
                    expect_json(id: 666, name: 'NAME', dateStarted: 146673416596, dateEnded: 146673416596, dateCreated: 146673530400, creatorid: 105502047) 
                end
            end
        end
        context 'DEL' do
            context 'delet activities' do
                it 'return 204 http code' do
                    del base_url + '/{activity_code}'
                    expect_status(204)
                end
            end
        end
    end
end
