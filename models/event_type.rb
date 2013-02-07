module EventType 
  @@mylogger    = Logger.new(STDOUT)

  def get_actions(cal_id, params={})
    return [] if Calendar.find(cal_id).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    actions = [] 
    ev_types = eval(self.class.name).where("code not in (?, ?, ?)", 'AC_OTH_AUTO', 'AC_REGIE', 'AC_OTH')
    @@mylogger.debug("#{self.class.name}: get actions EVENT TYPE <#{ev_types.to_s}>")
    if not ev_types.nil?
      actions = ev_types.to_a.map { |et|
        events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'") || []
        events 
      }.compact
    end
    @@mylogger.debug("#{self.class.name}: nbr d'actions : #{actions.size}")
    actions.to_a.flatten.map { |e| e.cal_id = cal_id }
    actions.to_a.flatten
  end


  def get_regies(cal_id, params={})
    return [] if Calendar.find(cal_id).hide
    regies = []
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    
    ev_type = eval(self.class.name).where('code = "AC_REGIE"').first
    @@mylogger.debug("#{self.class.name}: get regies EVENT TYPE <#{ev_type.to_s}>")
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
