ENV['RACK_ENV'] = 'calendars' # 'jobenfance'
require 'active_record'
# require 'rubygems'
# require 'sinatra'
# require 'sinatra/activerecord'
# require 'haml'
require 'logger'
# require './helpers/utils.rb'

# require './models/calendar'

require './models/jd_db'
require './models/je_db'


require './models/event_type'
require './models/event_type_je'
require './models/event_type_jd'

# require './models/event.rb'
# require './controllers/events.rb'
# require './models/event_types'
# require './models/event_je.rb'
# require './models/event_jd.rb'
require './axagenda'
require 'sinatra/activerecord/rake'

# to run tasks: $ RACK_ENV=jobenfance rake taks

set :database_file, './config/databases.yml'

desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "irb -r irb/completion -r ./back_srv.rb"
end


desc "start the app"
task :start, :environment do |t, args|
  puts args
  # ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "ruby back_srv.rb"
end


desc "load fixtures"
task :load_fixtures do |t|
  require './models/calendar.rb'
  exec "ruby db/seeds.rb"
end
