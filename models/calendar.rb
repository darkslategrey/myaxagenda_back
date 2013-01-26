class Calendar

  REGIE_JOBENFANCE      = 2
  REGIE_JOBDEPENDANCE   = 3
  ACTIONS_JOBENFANCE    = 4
  ACTIONS_JOBDEPENDANCE = 5

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
