module Event 

  def to_mycalendar(cal_id=1)
    self_json = self.to_json

    alerts  = EventAlert.where("dol_ev_id = #{self.id} and event_class_name = '#{self.class.name}'")
    uploads = Upload.where("ev_id = 904 and classname = '#{self.class.name}'")
    
    alertFlag = []
    alerts.each { |af|
      alert = {}
      alert['type'] = af.type_alert
      alert['early'] = af.early
      alert['unit'] = af.unit
      alert['emails'] = af.emails
      alert['id_alert_flag'] = af.id
      alertFlag.push(alert)
    }
    
    uploadedFiles = []
    uploads.each { |u| uploadedFiles.push(u.filepath) }

    endTime   = Utils.end_hour(self) + ':' + Utils.end_minute(self)
    startTime = Utils.start_hour(self) + ':' + Utils.start_minute(self)
    self.logger.info("StartTime : <"+startTime+"> endTime <"+endTime+">")
    my_json = { "calendarId" => self.cal_id,
      "subject"     =>  self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "repeatType"  =>  "no",
      "class"       =>  "CalendarEventUIModel",
      "endTime"     =>  endTime,
      "id"          =>  id,
      "startTime"   =>  startTime, 
      "alertFlag"   =>  alertFlag.size == 0 ? false : alertFlag.to_json,
      "color"       =>  Calendar.find(cal_id).color,
      "ymd"         =>  Utils.start_date(self),
      "description" =>  self.note.nil? ? '' : self.note.gsub(/\n/, ' '),
      "uploads"     => uploadedFiles.size == 0 ? false : uploadedFiles,
      "eymd"        => Utils.end_date(self).to_s,
      "societe"     => Utils.societe_url(self.societe),
      "contact"     => Utils.contact_url(self.contact),
      "userasked"   => self.user_asked.nil? ? '' : self.user_asked.rowid, # fk_user_author
      "userdone"    => self.user_done.nil? ? '' : self.user_done.rowid,
      "usertodo"    => self.user_todo.nil? ? '' : self.user_todo.rowid, # fk_user_action
      "locked"      =>  false }
    my_json
  end

  def to_doli(json)
    json_obj = JSON.parse(json.to_json)

    self.logger.info("json obj <"+ json_obj.to_s + ">")
    datep = json_obj['startDay'].nil? ? json_obj['ymd'] : json_obj['startDay']
    datep += ' '
    datep += json_obj['startHMTime'].nil? ? json_obj['startTime'] : json_obj['startHMTime']

    datep2 = json_obj['endDay'].nil? ? json_obj['eymd'] : json_obj['endDay']
    datep2 += ' '
    datep2 += json_obj['endHMTime'].nil? ? json_obj['endTime'] : json_obj['endHMTime']
    
    
    fulldayevent = 0
    json_obj['startDay'] == json_obj['endDay'] and json_obj['startHMTime'] == '00:00' and json_obj['endHHTime'] == '24:00' and fulldayevent = 1

    self.logger.info("to_doli <" + json_obj.to_s + ">")
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
      self.logger.error("Calendrier inconnu : <#{json_obj['calendarId']}>")
      e = Exception.new("Calendrier inconnu : <#{json_obj['calendarId']}>")
      raise e
    end

    doli_json = {
      "datec" =>  "#{datec}", # "2010-06-03T10:37:42+02:00",
      "datep" =>  "#{datep}", # 2010-06-03T10:37:42+02:00",
      "datep2" =>  "#{datep2}",# 2010-06-03T10:37:42+02:00",
      "fulldayevent" => fulldayevent,
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
    self.logger.info("apres conversion <"+ doli_json.to_s + ">")
    doli_json
  end

end

