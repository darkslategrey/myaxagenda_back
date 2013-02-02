require 'sinatra'

require 'sinatra/activerecord'
require 'haml'
require 'logger'

require './helpers/utils'
require 'active_record'

require './models/jd_db'
require './models/je_db'
require './models/cal_db'

require './models/event_alert'
require './models/calendar'

require './models/event_type'
require './models/event_type_je'
require './models/event_type_jd'

require './models/event'
require './models/event_je'
require './models/event_jd'

require './models/jd_user'
require './models/je_user'

# require './controllers/events'


class AxAgenda < Sinatra::Base

  # enable :logging

  # mylogger = Logger.new(STDOUT)

  get '/' do
    haml :index
  end

  post '/initialLoad' do
    # mylogger.info("initialLoad post")
    send_file 'public/init_load.json'
  end

  post '/loadEvent' do
    Calendar.set_all_visible
    events = Calendar.get_events(params)
    # events = EventsController.find_by_month(DateTime.current)
    # mylogger.debug("total events #{events.size}")
    my_events = events.map { |e| e.to_mycalendar }
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

  get '/users' do
    # mylogger.debug("get users")
    all_users = Calendar.get_all_users
    data = { 'success' => true, 'users' => all_users }
    haml data.to_json, :layout => false
  end

  # params : user_id : id#[je|jd]
  #          combo_name: [userasked|usertodo|userdone]
  post '/showOnlyUserEvent' do
    events = Calendar.get_events_by_user(params)
    my_events = events.map { |e| e.to_mycalendar }
    # mylogger.debug("showOnlyUserEvent: size <#{my_events.size}>")
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

  post '/createEvent' do
    Calendar.createEvent(params)
    data = { 'success' => true }
    haml data.to_json, :layout => false
  end

  post '/createUpdateCalendar' do
    events = Calendar.create_update_calendar(params)
    my_events = events.map { |e| e.to_mycalendar }
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

  post '/updateEvent' do
    begin
      Calendar.update_event(params)
    rescue Exception => e
      data = { 'success' => false, 'errorInfo' => "Oups! (appel le dev!) : " + e.message }
    else
      data = { 'success' => true }
    end
    haml data.to_json, :layout => false
  end

  post '/showOnlyCalendar' do
    events = Calendar.show_only_calendar(params)
    my_events = events.map { |e| e.to_mycalendar }
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

end


