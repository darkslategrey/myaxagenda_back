module Event 
  @@mylogger    = Logger.new(STDOUT)

  def to_mycalendar(cal_id=1)
    self_json = self.to_json

    endTime   = Utils.end_hour(self) + ':' + Utils.end_minute(self)
    startTime = Utils.start_hour(self) + ':' + Utils.start_minute(self)

    my_json = { "calendarId" => self.cal_id,
      "subject"     =>  self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "repeatType"  =>  "no",
      "class"       =>  "CalendarEventUIModel",
      "endTime"     =>  endTime,
      "id"          =>  self.id,
      "startTime"   =>  startTime, 
      "alertFlag"   =>  true,
      "color"       =>  Calendar.find(cal_id).color,
      "ymd"         =>  Utils.start_date(self),
      "description" =>  self.note.nil? ? '' : self.note.gsub(/\n/, ' '),
      "eymd"        => Utils.end_date(self).to_s,
      "userasked"   => self.user_asked.nil? ? '' : self.user_asked.rowid,
      "userdone"    => self.user_done.nil? ? '' : self.user_done.rowid,
      "usertodo"    => self.user_todo.nil? ? '' : self.user_todo.rowid,
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


    doli_json = {
      "datea" =>  nil,
      "datea2" =>  nil,
      "datec" =>  "#{datec}", # "2010-06-03T10:37:42+02:00",
      "datep" =>  "#{datep}", # 2010-06-03T10:37:42+02:00",
      "datep2" =>  "#{datep}",# 2010-06-03T10:37:42+02:00",
      "durationa" =>  nil,
      "durationp" =>  nil,
      "elementtype" =>  nil,
      "entity" =>  1,
      "fk_action" =>  50,
      "fk_contact" =>  nil,
      "fk_element" =>  nil,
      "fk_parent" =>  0,
      "fk_project" =>  nil,
      "fk_soc" =>  1,
      "fk_user_action" =>  json_obj['usertodo'].nil? ? '' : json_obj['usertodo'].split('#')[0],
      "fk_user_author" =>  json_obj['userId'],
      "fk_user_done" =>  json_obj['userdone'].nil? ? '' : json_obj['userdone'].split('#')[0],
      "fk_user_mod" =>  nil,
      "fulldayevent" =>  0,
      "id" =>  1,
      "label" =>  json_obj['subject'], # "Societe PEOPLE AND BABY ajoutee dans Dolibarr",
      "location" =>  "", 
      "note" =>  json_obj['description'], 
      "percent" =>  100,
      "priority" =>  0,
      "punctual" =>  1,
      "ref_ext" =>  nil,
      # "type_code" => 'AC_OTH',
      "tms" =>  Date.current 
    }
    doli_json
  end

end

