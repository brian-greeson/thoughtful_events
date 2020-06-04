# spec/spec_helper.rb
require 'simplecov'
SimpleCov.start
require 'dotenv'
Dotenv.load
require 'rack/test'
require 'rspec'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

ENV['RACK_ENV'] = 'test'

# require File.expand_path '../../thoughtful_events.rb', __FILE__
require '../thoughtful_events.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
