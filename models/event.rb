module Event 

  def to_mycalendar(cal_id=1)
    self_json = self.to_json

    endTime   = Utils.end_hour(self) + ':' + Utils.end_minute(self)
    startTime = Utils.start_hour(self) + ':' + Utils.start_minute(self)

    my_json = { "calendarId" => self.cal_id,
      "subject"     =>  self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "repeatType"  =>  "no",
      "class"       =>  "CalendarEventUIModel",
      "endTime"     =>  endTime,
      "id"          =>  id,
      "startTime"   =>  startTime, 
      "alertFlag"   =>  true,
      "color"       =>  Calendar.find(cal_id).color,
      "ymd"         =>  Utils.start_date(self),
      "description" =>  self.note.nil? ? '' : self.note.gsub(/\n/, ' '),
      "eymd"        => Utils.end_date(self).to_s,
      "userasked"   => self.user_asked.nil? ? '' : self.user_asked.rowid, # fk_user_author
      "userdone"    => self.user_done.nil? ? '' : self.user_done.rowid,
      "usertodo"    => self.user_todo.nil? ? '' : self.user_todo.rowid, # fk_user_action
      "locked"      =>  false }
    my_json
  end

  def to_doli(json)
    json_obj = JSON.parse(json.to_json)
    datec = json_obj['startDay'].nil? ? json_obj['ymd'] : json_obj['startDay']
    datec += ' '
    datec += json_obj['startHMTime'].nil? ? json_obj['startTime'] : json_obj['startHMTime']

    datep = json_obj['endDay'].nil? ? json_obj['eymd'] : json_obj['endDay']
    datep += ' '
    datep += json_obj['endHMTime'].nil? ? json_obj['endTime'] : json_obj['endHMTime']

    fk_action = nil

    case json_obj['calendarId'].to_i
    when Calendar::REGIE_JOBENFANCE
      fk_action = EventTypeJe.where('code = "AC_REGIE"').first.id
    when Calendar::REGIE_JOBDEPENDANCE
      fk_action = EventTypeJd.where('code = "AC_REGIE"').first.id
    when Calendar::ACTIONS_JOBENFANCE
      fk_action = EventTypeJe.where('code = "AC_OTH"').first.id
    when Calendar::ACTIONS_JOBDEPENDANCE
      fk_action = EventTypeJd.where('code = "AC_OTH"').first.id
    else
      @@logger.error("Calendrier inconnu : <#{json_obj['calendarId']}>")
      e = Exception.new("Calendrier inconnu : <#{json_obj['calendarId']}>")
      raise e
    end

    doli_json = {
      "datec" =>  "#{datec}", # "2010-06-03T10:37:42+02:00",
      "datep" =>  "#{datep}", # 2010-06-03T10:37:42+02:00",
      "datep2" =>  "#{datep}",# 2010-06-03T10:37:42+02:00",
      "entity" =>  1,
      "fk_action" => fk_action,
      "fk_user_action" =>  json_obj['usertodo'].nil? ? '' : json_obj['usertodo'].split('#')[0],
      "fk_user_author" =>  json_obj['userId'] || 1,
      "fk_user_done" =>  json_obj['userdone'].nil? ? '' : json_obj['userdone'].split('#')[0],
      "label" =>  json_obj['subject'], # "Societe PEOPLE AND BABY ajoutee dans Dolibarr",
      "location" =>  "", 
      "note" =>  json_obj['description'], 
      "percent" =>  0,
      "priority" =>  0,
      "punctual" =>  1,
      "ref_ext" =>  nil,
      "tms" =>  Date.current 
    }
    doli_json
  end

end

