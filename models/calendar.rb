
class Calendar < ActiveRecord::Base

  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['calendars']

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
    events += EventTypeJd.get_regies(params)
    events += EventTypeJd.get_actions(params)

    events += EventTypeJe.get_regies(params)
    events += EventTypeJe.get_actions(params)
    events.flatten
  end

  def self.show_only(id)
    events = []
    params = {}
    Calendar.find(id.to_i).update_attributes!({ :hide => false })
    case id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      @@mylogger.debug("regie_jobdependance")
      events = EventTypeJd.get_regies(params)
    when Calendar::REGIE_JOBENFANCE
      @@mylogger.debug("regie_jobenfance")
      events = EventTypeJe.get_regies(params)
    when Calendar::ACTIONS_JOBDEPENDANCE
      @@mylogger.debug("actions jobdependance")
      events = EventTypeJd.get_actions(params)
    when Calendar::ACTIONS_JOBENFANCE
      @@mylogger.debug("actions jobenfance")
      events = EventTypeJe.get_actions(params)
    else
      @@mylogger.debug("Calendar type not found <#{id}>")
    end
    events
  end

end
