
class Calendar < ActiveRecord::Base
  db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection db_config['calendars']

  REGIE_JOBENFANCE      = 1
  REGIE_JOBDEPENDANCE   = 2
  ACTIONS_JOBENFANCE    = 3
  ACTIONS_JOBDEPENDANCE = 4

  @@mylogger = Logger.new(STDOUT)


  def self.createUpdateRepeatEvent(params={})

    klass = Utils.cal_to_class(params['calendarId'])
    # calendarId:3
    # startDay:2012-11-15
    # endDay:2013-01-10
    # startHMTime:11:00
    # endHMTime:24:00
    # repeatType:{"rtype":"week","intervalSlot":1,"dspan":56,"beginDay":"2012-11-15","endDay":"no","rday":{"2":true,"3":true,"4":true}}
    # alertFlag:[{"type":"popup","early":30,"unit":"minute"}]
    # locked:false
    # subject:Appel tel et/ relance
    # description:
    #   userId:1
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

  def self.show_only(id)
    events = []
    params = {}
    Calendar.find(id.to_i).update_attributes!({ :hide => false })
    case id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      @@mylogger.debug("regie_jobdependance")
      events = EventTypeJd.first.get_regies(Calendar::REGIE_JOBDEPENDANCE)
    when Calendar::REGIE_JOBENFANCE
      @@mylogger.debug("regie_jobenfance")
      events = EventTypeJe.first.get_regies(Calendar::REGIE_JOBENFANCE)
    when Calendar::ACTIONS_JOBDEPENDANCE
      @@mylogger.debug("actions jobdependance")
      events = EventTypeJd.first.get_actions(Calendar::ACTIONS_JOBDEPENDANCE)
    when Calendar::ACTIONS_JOBENFANCE
      @@mylogger.debug("actions jobenfance")
      events = EventTypeJe.first.get_actions(Calendar::ACTIONS_JOBENFANCE)
    else
      @@mylogger.debug("Calendar type not found <#{id}>")
    end
    events
  end

  def self.get_all_users
    all_users = []
    JeUser.all.each { |u| 
      all_users.push({ 'completename' => u.firstname + ' ' + u.name, 'firstname' => u.firstname, 'name' => u.name, 'rowid' => u.rowid.to_s + '#je'})
    }
    JdUser.all.each { |u|
      all_users.push({ 'completename' => u.firstname + ' ' + u.name, 'firstname' => u.firstname, 'name' => u.name, 'rowid' => u.rowid.to_s + '#jd'})
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
    events
  end
  
end
