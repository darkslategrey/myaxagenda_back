require 'logger'

class Event < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  logger    = Logger.new(STDOUT)
  ActiveRecord::Base.logger = logger

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_actioncomm'
  self.primary_key = 'id'

  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventType'

  @@cal_ids = {
    'EventJe' => Calendar::ACTIONS_JOBENFANCE,
    'EventJd' => Calendar::ACTIONS_JOBDEPENDANCE,
    'RegieJe' => Calendar::REGIE_JOBENFANCE,
    'RegieJd' => Calendar::REGIE_JOBDEPENDANCE }
  
  # has_one :event_type, :foreign_key => 'fk_action'

  def end_hour
    hour_s = ''
    begin
      hour = DateTime.parse(self.datep.to_s).hour
      if(hour < 10)
        hour_s = '0'+hour.to_s
      else
        hour_s = hour.to_s
      end
    rescue ArgumentError
      hour_s = '00'
    end
    hour_s
  end

  def end_minute
    minute_s = ''
    begin
      minute = DateTime.parse(self.datep.to_s).minute
      if(minute < 10)
        minute_s = '0'+minute.to_s
      else
        minute_s = minute.to_s
      end
    rescue ArgumentError
      minute_s = '00'
    end
    minute_s
  end

  def end_day
    day = Date.parse(self.datep.to_s).day
    day_s = ''
    if(day < 10)
      day_s = '0'+day.to_s
    else
      day_s = day.to_s
    end
    day_s
  end

  def end_month
    month = Date.parse(self.datep.to_s).month
    month_s = ''
    if(month < 10)
      month_s = '0'+month.to_s
    else
      month_s = month.to_s
    end
    month_s
  end

  def end_year
    Date.parse(self.datep.to_s).year
  end

  def start_hour
    hour = DateTime.parse(self.datec.to_s).hour
    hour_s = ''
    if(hour < 10)
      hour_s = '0'+hour.to_s
    else
      hour_s = hour.to_s
    end
    hour_s
  end

  def start_minute
    minute = DateTime.parse(self.datec.to_s).minute
    minute_s = ''
    if(minute < 10)
      minute_s = '0'+minute.to_s
    else
      minute_s = minute.to_s
    end
    minute_s
  end

  def start_day
    day = Date.parse(self.datec.to_s).day
    day_s = ''
    if(day < 10)
      day_s = '0'+day.to_s
    else
      day_s = day.to_s
    end
    day_s
  end

  def start_month
    month = Date.parse(self.datec.to_s).month
    month_s = ''
    if(month < 10)
      month_s = '0'+month.to_s
    else
      month_s = month.to_s
    end
    month_s
  end

  def start_year
    Date.parse(self.datec.to_s).year
  end

  def start_date
    self.datec
  end

  def end_date
    self.datep
  end

  def to_mycalendar
    self_json = self.to_json

    endTime   = self.end_hour + ':' + self.end_minute
    startTime = self.start_hour + ':' + self.start_minute

    my_json = { "calendarId" => @@cal_ids[self.class.to_s],
      "subject" =>  self.label.nil? ? '' : self.label.gsub(/\n/, ' '),
      "repeatType" =>  "no",
      "class" =>  "CalendarEventUIModel",
      "endTime" =>  endTime,
      "id" =>  self.id,
      "startTime" =>  startTime, 
      "alertFlag" =>  true,
      "color" =>  "orange",
      "ymd" =>  Date.parse(self.start_date.to_s),
      "description" =>  self.note.nil? ? '' : self.note.gsub(/\n/, ' '),
      "eymd" => self.end_date.nil? ? '' : Date.parse(self.end_date.to_s),
      "locked" =>  false }
    my_json
  end

  def self.to_doli(json)
    json_obj = JSON.parse(json)
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
      "fk_user_action" =>  nil,
      "fk_user_author" =>  1,
      "fk_user_done" =>  1,
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

  def self.create_update(params)
    e = Event.new(params)
    res = e.save!
    res
  end

end

