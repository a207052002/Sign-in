ENV['RACK_ENV']||='test'
$no_log = true

require 'airbone'
#require 'spec_helper'  reverse word?
#require './spec-data'
#require './app'

RSpec.configure do |config|
    config.rack_app = Signin::API
    config.headers = {'X-Forwarded-For' => '127.0.0.1'}
end

describe Signin::API do

    base_url = 'self-defined/path'

#supposed to be token
    #
    #

context 'resource namespace' do
    context 'GET' do
        context 'with api token' do#But now we don't
            it 'return all namespace' do # while?
                get base_url + '/namespace', {'TOKEN'=>'TD::TOKEN'}
                expect_status 200
                expect_json_type :array
                namespace = json_body.first
                expect(namespace).to eq({
                    id: 1
                    name: 'signintest'
                    description: 'it is test'
                })
            end
        end

