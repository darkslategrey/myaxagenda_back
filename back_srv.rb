require 'active_record'
require 'rubygems'
require 'sinatra'
require 'haml'
require 'logger'
require 'soap/rpc/driver'
require 'sinatra/reloader'

# require './models/event_type.rb'
require './models/event.rb'
require './models/calendar.rb'
require './controllers/events.rb'


enable :logging
logger = Logger.new(STDOUT)

set :port, 6789


ActiveRecord::Base.clear_active_connections!
ActiveRecord::Base.establish_connection(:adapter  => 'mysql2',
                                        :host     => 'localhost',
                                        :username => 'root',
                                        :password => 'admin',
                                        :pool => 100,
                                        :database => 'dolibarr-integ')

# before do 
#   ActiveRecord::Base.establish_connection(:adapter  => 'mysql2',
#                                           :host     => 'localhost',
#                                           :username => 'root',
#                                           :password => 'admin',
#                                           :database => 'dolibarr-integ')
# end
# after do
#   ActiveRecord::Base.clear_active_connections!
# end

post '/search.json' do 
  'search'
end
post '/showAllCalendar.json' do 
  'showAllCalendar'
end
post '/showOnly.json' do 
  logger.debug(params)
  events = Calendar.show_only(params['id'])
  my_events = events.map { |e| e.to_my(params['id']) }
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
  # data = "{ 'success': 'false', 'errorInfo': 'c debile vraiment' }"
  logger.debug(data)
  haml data.to_json, :layout => false
  # require 'net/http
  # actioncomm = Event.to_doli(params.to_json)
  # driver = SOAP::RPC::Driver.new('http://dolibarr-integ.local:88/webservices/server_actioncomm.php/webservices/server_actioncomm.php',
  #                                'urn:http://www.dolibarr.org/ns/')
  # driver.add_method('createActionComm', 'authentication', 'actioncomm')
  # creation_msg = driver.createActionComm({ "login" => "Maud", "pass" => "Minnie75" }, actioncomm) # params
  # logger.debug("CREATION_MSG <"+creation_msg+">")

  # events = Event.new(params)
  # my_events = events.map { |e| e.to_my }
  # data = {'total' =>  my_events.size, 'results' => my_events }
  # haml data.to_json, :layout => false

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
  events = Event.find_by_month(DateTime.current)
  my_events = events.map { |e| e.to_my }
  data = {'total' =>  my_events.size, 'results' => my_events }
  haml data.to_json, :layout => false
end

