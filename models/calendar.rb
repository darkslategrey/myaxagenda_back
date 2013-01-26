class Calendar < ActiveRecord::Base

  REGIE_JOBENFANCE      = 1
  REGIE_JOBDEPENDANCE   = 2
  ACTIONS_JOBENFANCE    = 3
  ACTIONS_JOBDEPENDANCE = 4

  @@logger = Logger.new(STDOUT)

  def self.show_only(id)
    events = []

    case id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      @@logger.debug("regie_jobdependance")
      events = EventTypeJd.regie_jobdependance
    when Calendar::REGIE_JOBENFANCE
      @@logger.debug("regie_jobenfance")
      events = EventTypeJe.regie_jobenfance
    when Calendar::ACTIONS_JOBDEPENDANCE
      @@logger.debug("actions jobdependance")
      events = EventTypeJd.get_actions
    when Calendar::ACTIONS_JOBENFANCE
      @@logger.debug("actions jobenfance")
      events = EventTypeJe.get_actions
    else
      @@logger.debug("Calendar type not found <#{id}>")
    end
    events
  end

end
