# -*- coding: utf-8 -*-
require 'sinatra'

require 'sinatra/activerecord'
require 'haml'
# require 'logger'

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

require './models/je_societe'
require './models/jd_societe'

require './models/je_contact'
require './models/jd_contact'

require './models/upload'

# require './controllers/events'


class AxAgenda < Sinatra::Base

  # enable :logging

  # mylogger = Logger.new(STDOUT)

  # logger = ENV['rack.logger']
  set :username,'axagenda'
  set :password,'axagenda'
  set :token,'osh@kerp@$@l@cuill3re'


  @@logger          = Logger.new('log/axagenda.log')
  @@logger.level    = Logger::INFO
  @@logger.progname = "AxAgenda"

  JdDB.logger  = @@logger
  JeDB.logger  = @@logger
  EventJe.logger = @@logger
  EventJd.logger = @@logger
  EventTypeJe.logger = @@logger
  EventTypeJd.logger = @@logger

  # @@logger.level    = Logger::DEBUG
  Calendar.logger = @@logger

  helpers do
    def admin? ; request.cookies[settings.username] == settings.token ; end
    def protected! ; redirect url '/login' unless admin? ; end
  end




  get '/' do
    protected!
    haml :index
  end

  post '/login' do
    if params['username'] == settings.username && params['password'] == settings.password
      response.set_cookie(settings.username,settings.token) 
      redirect '/'
    else
      redirect url '/login'
    end
  end

  get '/login' do
    haml :admin, :layout => :admin_layout
  end

  post '/initialLoad' do
    @@logger.info("initialLoad post")
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
    @@logger.info("get users")
    all_users = Calendar.get_all_users
    data = { 'success' => true, 'users' => all_users }
    haml data.to_json, :layout => false
  end

  # params : user_id : id#[je|jd]
  #          combo_name: [userasked|usertodo|userdone]
  post '/showOnlyUserEvent' do
    @@logger.info("showOnlyUserEvent #{params.to_s}")
    events = Calendar.get_events_by_user(params)
    my_events = events.map { |e| e.to_mycalendar }
    # mylogger.debug("showOnlyUserEvent: size <#{my_events.size}>")
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

  post '/createEvent' do
    @@logger.info("Create Event #{params.to_s}")
    begin
      event = Calendar.createEvent(params)
    rescue Exception => e
      data = { 'success' => false, 'errorInfo' => e.message }
    else
      data = { 'success' => true, 'eventId' => event.id  }
    end
    haml data.to_json, :layout => false
  end

  post '/createUpdateCalendar' do
    events = Calendar.create_update_calendar(params)
    my_events = events.map { |e| e.to_mycalendar }
    data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    haml data.to_json, :layout => false
  end

  post '/updateEvent' do
    @@logger.info("updateEvent: " + params.to_s)
    begin
      Calendar.update_event(params)
    rescue Exception => e
      @@logger.error("Update error : " + e.message)
      data = { 'success' => false, 'errorInfo' => "Oups! (appel le dev!) : " + e.message }
    else
      @@logger.info("Update ok")
      data = { 'success' => true }
    end
    haml data.to_json, :layout => false
  end

  post '/showOnlyCalendar' do
    # events = Calendar.show_only_calendar(params)
    # my_events = events.map { |e| e.to_mycalendar }
    # data = {'total' =>  my_events.size, 'results' => my_events, 'success' => true }
    data = {'total' =>  0, 'results' => [], 'success' => true }
    haml data.to_json, :layout => false
  end

  # {"event_id"=>"", "banniere"=>{:filename=>"www-data.sh", :type=>"application/x-shellscript", :name=>"banniere", :tempfile=>#<File:/tmp/RackMultipart20130203-10261-l7eblx>, :head=>"Content-Disposition: form-data; name=\"banniere\"; filename=\"www-data.sh\"\r\nContent-Type: application/x-shellscript\r\n"}}
  post '/fileUpload' do
    @@logger.info("into fileUpload " + params.to_s)
    filename = ""
    begin
      filename = Calendar.store_file(params['event_id'], 
                                     params['cal_id2'],
                                     params['banniere'][:tempfile], 
                                     params['banniere'][:filename])
    rescue Exception => e
      @@logger.error("Oups! #{e.message}")
      data = { 'success' => false, 'errorInfo' => "Oups! Problème : " + e.message }
    else
      data = { 'success' => true, 'filename' => filename }
    end
    @@logger.info("returned value : #{data.to_s}")
    haml data.to_json, :layout => false
  end

end


