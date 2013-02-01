# -*- coding: utf-8 -*-
class Calendar < ActiveRecord::Base
  db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection db_config['calendars']

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
      all_users.push({ 'completename' => u.firstname + ' Jobenfance', 'firstname' => u.firstname, 'name' => u.name, 'rowid' => u.rowid.to_s + '#je'})
    }
    JdUser.all.each { |u|
      next if u.name == 'SuperAdmin' or not u.has_events?
      all_users.push({ 'completename' => u.firstname + ' Jobdépendance', 'firstname' => u.firstname, 'name' => u.name, 'rowid' => u.rowid.to_s + '#jd'})
    }
    all_users
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
  
end
