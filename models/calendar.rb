class Calendar

  REGIE_JOBENFANCE      = 2
  REGIE_JOBDEPENDANCE   = 3
  ACTIONS_JOBENFANCE    = 4
  ACTIONS_JOBDEPENDANCE = 5

  def self.show_only(id)
    events = []
    logger = Logger.new(STDOUT)
    case id.to_i
    when Calendar::REGIE_JOBDEPENDANCE
      logger.debug("regie_jobdependance")
      events = Event.where('fk_action = 51')
    when Calendar::REGIE_JOBENFANCE
      logger.debug("regie_jobenfance")
      events = Event.where('fk_action = 52')
    when Calendar::ACTIONS_JOBDEPENDANCE, Calendar::ACTIONS_JOBENFANCE
      logger.debug("actions")
      events = Event.where('fk_action < 51')
    else
      logger.debug("Calendar type not found <#{id}>")
    end
    events
  end

end
