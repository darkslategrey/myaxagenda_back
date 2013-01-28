# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'logger'

require './helpers/utils.rb'
require 'active_record'
require './models/calendar.rb'
require './models/event.rb'
require './controllers/events.rb'

require './models/event_types.rb'
# require './models/event_type_je.rb'
# require './models/event_type_jd.rb'

require './models/event_je.rb'
require './models/event_jd.rb'

# require './models/regie_je.rb'
# require './models/regie_jd.rb'

disable :logging

mylogger = Logger.new(STDOUT)

set :port, 6789

# ActiveRecord::Base.timestamped_migrations = false

post '/search.json' do 
  'search'
end
post '/showAllCalendar.json' do 
  'showAllCalendar'
end

post '/showOnly.json' do 
  mylogger.debug(params)
  events = Calendar.show_only(params['id'])
  my_events = events.map { |e| e.to_mycalendar }
  mylogger.debug("showOnly.events size <#{my_events.size}>")
  data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }

  haml data.to_json, :layout => false
end

post '/createUpdate.json' do 
  mylogger.debug("CreateUpdateCalendar")
  Calendar.updateCreate(params)
  events = Calendar.get_events
  my_events = events.map { |e| e.to_mycalendar }
  mylogger.debug("createUpdateCalendar events size <#{my_events.size}>")
  data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
  haml data.to_json, :layout => false
end

post '/deleteEventsByCalendar.json' do 
  'deleteEventsByCalendar'
end
post '/deleteCalendar.json' do 
  'deleteCalendar'
end
post '/loadCalendar.json' do 
  'loadCalendar'
end
post '/loadEvent.json' do 
  'loadEvent'
end
post '/loadRepeatEvent.json' do 
  'loadRepeatEvent'
end

post '/createEditEvent.json' do 
  mylogger.debug(params)
  res = Event.create_update(Event.to_doli(params.to_json))
  data = { 'success' => res, 'errorInfo' => '' }
  mylogger.debug(data)
  haml data.to_json, :layout => false
end

post '/createEvent.json' do 
  'createEvent'
end
post '/updateEvent.json' do 
  'updateEvent'
end
post '/deleteEvent.json' do 
  'deleteEvent'
end
post '/deleteRepeatEvent.json' do 
  'deleteRepeatEvent'
end
post '/changeDay.json' do 
  'changeDay'
end
post '/deleteDay.json' do 
  'deleteDay'
end
post '/loadSetting.json' do 
  'loadSetting'
end
post '/updateSetting.json' do 
  'updateSetting'
end

post '/createUpdateRepeatEvent.json' do 
  mylogger.debug(params)
  Calendar.createUpdateRepeatEvent(params)
end

post '/listUser.json' do 
  'listUser'
end


get '/fakeData/listEvent.json' do
  Calendar.set_all_visible
  events = Calendar.get_events(params)
  # events = EventsController.find_by_month(DateTime.current)
  mylogger.debug("total events #{events.size}")
  my_events = events.map { |e| e.to_mycalendar }
  data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
  haml data.to_json, :layout => false
end

