ENV['RACK_ENV'] = 'calendars' # 'jobenfance'
require 'active_record'
require 'logger'

require './models/jd_db'
require './models/je_db'
require './models/cal_db'

require './models/event_alert'
require './models/event_type'
require './models/event_type_je'
require './models/event_type_jd'

require './axagenda'
require 'sinatra/activerecord/rake'

# to run tasks: $ RACK_ENV=jobenfance rake taks

set :database_file, './config/databases.yml'

desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "irb -r irb/completion -r ./axagenda.rb"
end

desc "Remove tilde files"
task :clean do |t|
  exec 'find -name \*~ -exec rm {} \;'
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
