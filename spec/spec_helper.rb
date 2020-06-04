# spec/spec_helper.rb
require 'simplecov'
SimpleCov.start
require 'dotenv'
Dotenv.load
require 'rack/test'
require 'rspec'
require 'webmock/rspec'
require './serializers/ticketmaster_serializer'
require './services/ticketmaster_service'
WebMock.disable_net_connect!(allow_localhost: true)

ENV['RACK_ENV'] = 'test'

require './thoughtful_events'

module RSpecMixin
  include Rack::Test::Methods
  def app() ThoughtfulEvents end
end

RSpec.configure { |c| c.include RSpecMixin }
