# -*- coding: utf-8 -*-
require 'active_record'
require 'rubygems'
require 'sinatra'
require 'haml'
require 'logger'

require './models/calendar.rb'
require './models/event.rb'
require './controllers/events.rb'

require './models/event_type.rb'
require './models/event_type_je.rb'
require './models/event_type_jd.rb'

require './models/event_je.rb'
require './models/event_jd.rb'

require './models/regie_je.rb'
require './models/regie_jd.rb'

enable :logging
logger = Logger.new(STDOUT)

set :port, 6789


post '/search.json' do 
  'search'
end
post '/showAllCalendar.json' do 
  'showAllCalendar'
end
post '/showOnly.json' do 
  logger.debug(params)
  events = Calendar.show_only(params['id'])
  my_events = events.map { |e| e.to_mycalendar }
  data = {'total' =>  my_events.size, 'results' => my_events }
  logger.debug("showOnly.events size <#{data}>")
  haml data.to_json, :layout => false
end

post '/createUpdateCalendar.json' do 
  'createUpdateCalendar'
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
  logger.debug(params)
  res = Event.create_update(Event.to_doli(params.to_json))
  data = { 'success' => res, 'errorInfo' => '' }
  logger.debug(data)
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
  logger.debug(params)
end

post '/listUser.json' do 
  'listUser'
end


get '/fakeData/listEvent.json' do
  events = EventsController.find_by_month(DateTime.current)
  logger.debug("total events #{events.size}")
  my_events = events.map { |e| e.to_mycalendar }
  data = {'total' =>  my_events.size, 'results' => my_events }
  haml data.to_json, :layout => false
end

