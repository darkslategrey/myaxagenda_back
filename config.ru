
require 'sinatra'
require './axagenda'



use Rack::ShowExceptions
enable :raise_errors

# use Rack::CommonLogger, logger
# kuse MyLogger, logger

# RackLogger.new(AxAgenda, Logger.new)

run AxAgenda






