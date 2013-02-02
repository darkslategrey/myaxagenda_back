require 'simplecov'
SimpleCov.start do 
  add_filter '/db/'    
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/views/'
end

RACK_ENV = "test"
require File.join(File.dirname(__FILE__), "..", "axagenda.rb")
require "rack/test"
require "rspec"

set :environment, :calendars
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
