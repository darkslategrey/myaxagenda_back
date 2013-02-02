# -*- coding: utf-8 -*-
require './models/cal_db'

class Calendar < CalDB # ActiveRecord::Base
  # db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  # establish_connection db_config['calendars']

  attr_accessible :id, :name, :code, :description, :color, :hide

  ACTIONS_JOBENFANCE    = 1
  ACTIONS_JOBDEPENDANCE = 2

  REGIE_JOBENFANCE      = 3
  REGIE_JOBDEPENDANCE   = 4

  # @@mylogger = Logger.new(STDOUT)


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
  def self.createEvent(params={})
    # logger.info("Calendar.createEvent")
    klass = Utils.cal_to_class(params['calendarId'])
    klass.new(klass.first.to_doli(params)).save!
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
    events += EventTypeJd.first.get_regies(Calendar::REGIE_JOBDEPENDANCE)
    events += EventTypeJd.first.get_actions(Calendar::ACTIONS_JOBDEPENDANCE)

    events += EventTypeJe.first.get_regies(Calendar::REGIE_JOBENFANCE)
    events += EventTypeJe.first.get_actions(Calendar::ACTIONS_JOBENFANCE)
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
    user_id, db = params['user_id'].split('#')
    user_id = user_id.to_i
    filtername = params['combo_name']
    klass = ''
    if db == 'je'
      klass = eval('JeUser')
    else
      klass = eval('JdUser')
    end
    
    case filtername
    when 'userasked'
      events = klass.find(user_id).events_author
    when 'userdone'
      events = klass.find(user_id).events_done
    when 'usertodo'
      events = klass.find(user_id).events_todo
    end
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
    params['alertFlag']  && Calendar.set_alert(event, params['alertFlag'])
    params['repeatFlag'] &&  Calendar.set_repeat(event, params['repeatType'])
    event.update_attributes!(event.to_doli(params))
  end

  # [{"type":"email","early":30,"unit":"minute","emails":"dfd, fdfds"}]
  def self.set_alert(event, alerts)
    alerts.each { |alert| 
      ea = EventAlert.find_or_create_by_dol_ev_id(:dol_ev_id => event.id)
      ea.update_attributes!(:type_alert => alert['type'],
                            :early => alert['early'].to_i,
                            :unit => alert['unit'],
                            :emails => alert['emails'])
    }
  end
 
  # {"rtype":"day","intervalSlot":2,"dspan":20,"beginDay":"2013-01-29","endDay":"2014-01-23"}
  def self.set_repeat(event, repeatFlag)
  end

end
