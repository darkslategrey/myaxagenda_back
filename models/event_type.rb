module EventType 
  @@mylogger    = Logger.new(STDOUT)

  def get_actions(cal_id)
    return [] if Calendar.find(cal_id).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    actions = []
    ev_types = EventTypeJd.where('code != "AC_REGIE"')
    @@mylogger.debug("JD get action EVENT TYOE <#{ev_types}>")
    if not ev_types.nil?
      actions = ev_types.to_a.map { |et|
        events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'") || []
        events 
      }.compact
    end
    @@mylogger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a.flatten.map { |e| e.cal_id = cal_id }
    actions.to_a.flatten
  end


  def get_regies(cal_id)
    return [] if Calendar.find(cal_id).hide
    regies = []
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    
    ev_type = EventTypeJd.where('code = "AC_REGIE"').first
    @@mylogger.debug("JD get regie EVENT TYOE <#{ev_type}>")
    if not ev_type.nil?
      events = ev_type.events
    end
    if not events.nil?
      regies = events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a.flatten || []
    end
    regies.map { |e| e.cal_id = cal_id } 
    @@mylogger.debug("#{self.class.name}: nbr de regies: #{regies.size}")
    regies.to_a.flatten 
  end

end
