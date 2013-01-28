
class Calendar < ActiveRecord::Base

  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['calendars']

  REGIE_JOBENFANCE      = 1
  REGIE_JOBDEPENDANCE   = 2
  ACTIONS_JOBENFANCE    = 3
  ACTIONS_JOBDEPENDANCE = 4

  @@mylogger = Logger.new(STDOUT)


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

  def self.get_events
    events = []
    events += EventTypeJd.get_regies
    events += EventTypeJd.get_actions

    events += EventTypeJe.get_regies
    events += EventTypeJe.get_actions
    events.flatten
  end

  def self.show_only(id)
    events = []
    Calendar.find(id.to_i).update_attributes!({ :hide => false })
    case id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      @@mylogger.debug("regie_jobdependance")
      events = EventTypeJd.get_regies
    when Calendar::REGIE_JOBENFANCE
      @@mylogger.debug("regie_jobenfance")
      events = EventTypeJe.get_regies
    when Calendar::ACTIONS_JOBDEPENDANCE
      @@mylogger.debug("actions jobdependance")
      events = EventTypeJd.get_actions
    when Calendar::ACTIONS_JOBENFANCE
      @@mylogger.debug("actions jobenfance")
      events = EventTypeJe.get_actions
    else
      @@mylogger.debug("Calendar type not found <#{id}>")
    end
    events
  end

end
