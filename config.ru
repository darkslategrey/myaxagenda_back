
require 'sinatra'
require './axagenda'


use Rack::ShowExceptions
enable :raise_errors

class MyLogger < Logger
  def write(msg)
    msg
  end
end

# logger.sync     = true

# use Rack::CommonLogger, mylogger

use Rack::Lint

run AxAgenda








