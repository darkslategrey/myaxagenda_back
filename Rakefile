require './back_srv.rb'
require 'sinatra/activerecord/rake'
 


desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "irb -r irb/completion -r ./back_srv.rb"
end


desc "start the app"
task :start, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'
  exec "ruby back_srv.rb"
end
