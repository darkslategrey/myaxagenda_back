ENV['RACK_ENV'] = 'calendars' # 'jobenfance'
require 'sinatra/activerecord/rake'
require './back_srv.rb'

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
  ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "ruby back_srv.rb"
end

