# -*- coding: utf-8 -*-

class Calendar < CalDB # ActiveRecord::Base
  # db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  # establish_connection db_config['calendars']

  attr_accessible :id, :name, :code, :description, :color, :hide

  @@logger

  ACTIONS_JOBENFANCE    = 1
  ACTIONS_JOBDEPENDANCE = 2

  REGIE_JOBENFANCE      = 3
  REGIE_JOBDEPENDANCE   = 4

  # @@mylogger = Logger.new(STDOUT)


  def hidden?
    hide == true
  end

  # calendarId:1
  # startDay:2013-01-29
  # endDay:2013-01-29
  # startHMTime:12:00
  # endHMTime:13:00
  # repeatType:no
  # alertFlag:null
  # locked:false
  # subject:test greg 1
  # description:encore un test  
  # usertodo:2#je
  # userdone:3#je
  # alertFlag: [{"type":"email","early":30,"unit":"minute","emails":"a@b.c, d@e.fr"}]
  # uploadfile:C:\fakepath\grego-calibre-gui.socket
  # userId:1
  # Create Event {"calendarId"=>"4", "startDay"=>"2013-01-28", "endDay"=>"2013-02-03", "startHMTime"=>"09:00", "endHMTime"=>"10:00", "repeatType"=>"no", "alertFlag"=>"[{\"type\":\"email\",\"early\":3,\"unit\":\"jour\",\"emails\":\"e.pecqueur@aerocontact.com,\\nr.delandesen@aerocontact.com,\\nmvignes@jobenfance.com\"}]", "locked"=>"false", "subject"=>"greg creation", "description"=>"whell", "usertodo"=>"2#je", "userdone"=>"", "uploadfile"=>"", "userId"=>"1"}
  def self.createEvent(params={})
    event = nil
    klass       = Utils.cal_to_class(params['calendarId'])
    alert_flags = params['alertFlag']
    @@logger.info("Création d'un event #{klass.to_s}")
    begin
      @@logger.info("Avant conversion !!!!!!!!  ")
      @@logger.info("klass first <"+ klass.to_s + ">")
      event = klass.new(klass.first.to_doli(params))
      @@logger.info("après conversion")
      event.save!
      @@logger.info("aprs sauvegarde")
      if(alert_flags != "null")
        self.set_alert(event, alert_flags)
      end
      @@logger.info("apres set alert")
    rescue Exception => e
      error_msg = e.backtrace.join("\n")
      @@logger.error("Oups! " + error_msg)
      raise e
    end
    event
  end


  def self.createUpdateRepeatEvent(params={})

    klass = Utils.cal_to_class(params['calendarId'])
    klass.new(klass.first(to_doli(params))).save!
    # calendarId:3
    # startDay:2012-11-15
    # endDay:2013-01-10
    # startHMTime:11:00
    # endHMTime:24:00
    # repeatType:{"rtype":"week","intervalSlot":1,"dspan":56,"beginDay":"2012-11-15","endDay":"no","rday":{"2":true,"3":true,"4":true}}
    # alertFlag:[{"type":"popup","early":30,"unit":"minute"}]
    # locked:false
    # usertodo: id#[je|jd]
    # userdone: id#[je|jd]
    # subject:Appel tel et/ relance
    # description:
    #   userId:1 (userauthor)
    # id:661
    # oldRepeatType:no

  end

  def self.delete_event(params)
    cal_id = params['cal_id'].to_i
    klass = Utils.cal_to_class(cal_id)
    begin 
      klass.delete(params['id'].to_i)
    rescue Exception => e
      raise e
    end
  end

  def self.updateCreate(params)
    params.delete('userId')
    calendar = Calendar.find(params['id'])
    calendar.update_attributes!(params)
  end

  def self.set_all_visible
    Calendar.all.each { |c| 
      c.update_attributes!({ :hide => false })
    }
  end

  def self.get_events(params={})
    events = []
    events += EventTypeJd.first.get_regies(Calendar::REGIE_JOBDEPENDANCE, params)
    events += EventTypeJd.first.get_actions(Calendar::ACTIONS_JOBDEPENDANCE, params)

    events += EventTypeJe.first.get_regies(Calendar::REGIE_JOBENFANCE, params)
    events += EventTypeJe.first.get_actions(Calendar::ACTIONS_JOBENFANCE, params)
    events.flatten
  end

  def self.show_only_calendar(params)

    events = []
    cal_id    = params['id']
    # userasked = params['userasked'] => id_user#[je|jd]
    # usertodo  = params['usertodo']
    # userdone  = params['userdone']

    Calendar.find(cal_id.to_i).update_attributes!({ :hide => false })
    case cal_id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      # mylogger.debug("regie_jobdependance")
      events = EventTypeJd.first.get_regies(Calendar::REGIE_JOBDEPENDANCE, params)
    when Calendar::REGIE_JOBENFANCE
      # mylogger.debug("regie_jobenfance")
      events = EventTypeJe.first.get_regies(Calendar::REGIE_JOBENFANCE, params)
    when Calendar::ACTIONS_JOBDEPENDANCE
      # mylogger.debug("actions jobdependance")
      events = EventTypeJd.first.get_actions(Calendar::ACTIONS_JOBDEPENDANCE, params)
    when Calendar::ACTIONS_JOBENFANCE
      # mylogger.debug("actions jobenfance")
      events = EventTypeJe.first.get_actions(Calendar::ACTIONS_JOBENFANCE, params)
    else
      # mylogger.debug("Calendar type not found <#{id}>")
    end
    events
  end

  def self.get_all_users
    all_users = []
    JeUser.all.each { |u| 
      next if u.name == 'SuperAdmin' or not u.has_events?
      all_users.push({ 'completename' => u.firstname + ' Jobenfance', 
                       'firstname' => u.firstname, 'name' => u.name, 
                       'rowid' => u.rowid.to_s + '#je'})
    }
    JdUser.all.each { |u|
      next if u.name == 'SuperAdmin' or not u.has_events?
      all_users.push({ 'completename' => u.firstname + ' Jobdépendance', 
                       'firstname' => u.firstname, 'name' => u.name, 
                       'rowid' => u.rowid.to_s + '#jd'})
    }
    all_users
  end

  # id:3
  # name:Bannières Jobenfance
  # description:Bannières Jobenfance
  # color:red
  # hide:true
  # userId:1
  def self.create_update_calendar(params)
    events = []
    Calendar.find(params['id']).update_attributes!({ :color => params['color'],
                                                   :name => params['name'],
                                                   :hide => params['hide'],
                                                   :description => params['description'] })
    Calendar.all.each { |c|
      next if c.hide
      case c.id.to_i
      when Calendar::REGIE_JOBDEPENDANCE
        events = EventTypeJd.first.get_regies(Calendar::REGIE_JOBDEPENDANCE, params)
      when Calendar::REGIE_JOBENFANCE
        events = EventTypeJe.first.get_regies(Calendar::REGIE_JOBENFANCE, params)
      when Calendar::ACTIONS_JOBDEPENDANCE
        events = EventTypeJd.first.get_actions(Calendar::ACTIONS_JOBDEPENDANCE, params)
      when Calendar::ACTIONS_JOBENFANCE
        events = EventTypeJe.first.get_actions(Calendar::ACTIONS_JOBENFANCE, params)
      else
        # mylogger.debug("Calendar type not found <#{id}>")
      end
    }
    events
  end

  def self.get_events_by_user(params)
    # format : 3#je,1#je,2#je
    userasked, usertodo = params.values
    users_filter = { 'users_asked' => { 'je' => [], 'jd' => [] },
                     'users_todo'  => { 'je' => [], 'jd' => [] } }
    if(not userasked.nil?)
      userasked.split(',').each { |ua|
        user_id, agenda = ua.split('#')
        users_filter['users_asked'][agenda].push(user_id.to_i)
      }
    end
    if(not usertodo.nil?)
      usertodo.split(',').each { |utd|
        user_id, agenda = utd.split('#')
        users_filter['users_todo'][agenda].push(user_id.to_i)
      }
    end
    events = []
    [ Calendar::ACTIONS_JOBENFANCE, Calendar::ACTIONS_JOBDEPENDANCE,
      Calendar::REGIE_JOBENFANCE, Calendar::REGIE_JOBDEPENDANCE ].each { |agenda|
      next if Calendar.find(agenda).hidden?
      case agenda
      when Calendar::ACTIONS_JOBENFANCE
        if(users_filter['users_asked']['je'].size > 0)
          events += EventTypeJe.first.find_actions_by_author(users_filter['users_asked']['je'])
        end
        if(users_filter['users_todo']['je'].size > 0)
          events += EventTypeJe.first.find_actions_by_todo(users_filter['users_todo']['je'])
        end
      when Calendar::ACTIONS_JOBDEPENDANCE
        if(users_filter['users_asked']['jd'].size > 0)
          events += EventTypeJd.first.find_actions_by_author(users_filter['users_asked']['jd'])
        end
        if(users_filter['users_todo']['jd'].size > 0)
          events += EventTypeJd.first.find_actions_by_todo(users_filter['users_todo']['jd'])
        end
      when Calendar::REGIE_JOBENFANCE
        if(users_filter['users_asked']['je'].size > 0)
          events += EventTypeJe.first.find_regies_by_author(users_filter['users_asked']['je'])
        end
        if(users_filter['users_todo']['je'].size > 0)
          events += EventTypeJe.first.find_regies_by_todo(users_filter['users_todo']['je'])
        end
      when Calendar::REGIE_JOBDEPENDANCE
        if(users_filter['users_asked']['jd'].size > 0)
          events += EventTypeJe.first.find_regies_by_author(users_filter['users_asked']['jd'])
        end
        if(users_filter['users_todo']['jd'].size > 0)
          events += EventTypeJe.first.find_regies_by_todo(users_filter['users_todo']['jd'])
        end
      end
    }
    events.flatten!
    @@logger.info("Calendar.get_events_by_user: nbr of events found <#{events.size}>")
    events
  end


  # id:895
  # calendarId:1
  # startDay:2013-02-01
  # endDay:2013-02-01
  # startHMTime:10:00
  # endHMTime:11:00
  # repeatType:no
  # alertFlag:true
  # locked:false
  # subject:
  # description:
  def self.update_event(params)
    klass = Utils.cal_to_class(params['calendarId'])
    begin
      event = klass.find(params['id'])
    rescue ActiveRecord::RecordNotFound
      raise
    end
    Calendar.set_alert(event, params['alertFlag'])
    @@logger.info("into Calendar.set_alert")
    params['repeatFlag'] &&  Calendar.set_repeat(event, params['repeatType'])
    event.update_attributes!(event.to_doli(params))
  end

  # [{"type":"email","early":30,"unit":"minute","emails":"dfd, fdfds"}]
  def self.set_alert(event, alerts)
    return if alerts.nil? or alerts == "null" or alerts == false or alerts == "false" or alerts.size == 0 # or alerts == /null|true|false/ 

    alerts = JSON.parse(alerts)
    alerts.each { |alert| 
      ea = EventAlert.find_or_create_by_dol_ev_id(:dol_ev_id => event.id)
      ea.update_attributes!(:type_alert => alert['type'],
                            :event_class_name => event.class.name,
                            :early => alert['early'].to_i,
                            :unit => alert['unit'],
                            :emails => alert['emails'].gsub(/\s/, ''))
      @@logger.info("Creation alerte: #{ea.to_s}")
    }
  end
 
  # {"rtype":"day","intervalSlot":2,"dspan":20,"beginDay":"2013-01-29","endDay":"2014-01-23"}
  def self.set_repeat(event, repeatFlag)
  end


  def self.store_file(event_id, cal_id, filepath, filename)
    dirpath = "documents/#{event_id}"
    @@logger.debug("Pwd: #{FileUtils.pwd} / Start saving uploaded file into <#{dirpath}> ")
    begin
      FileUtils::mkdir_p(dirpath)
      File.open("#{dirpath}/#{filename}", 'w') do |f|
        f.write(filepath.read)
      end
      upload = Upload.new(:filepath => "#{dirpath}/#{filename}", 
                          :ev_id => event_id.to_i, 
                          :classname => Utils.cal_to_class(cal_id).name)
      upload.save!
    rescue 
      raise
    end
    "#{dirpath}/#{filename}"
  end
end



