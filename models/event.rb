require 'logger'

class Event < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  logger    = Logger.new(STDOUT)
  # ActiveRecord::Base.logger = logger
  attr_accessor :cal_id
  # @cal_id = nil

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_actioncomm'
  self.primary_key = 'id'

  # belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventType'

  @@cal_ids = {
    'EventJe' => Calendar::ACTIONS_JOBENFANCE,
    'EventJd' => Calendar::ACTIONS_JOBDEPENDANCE,
    'RegieJe' => Calendar::REGIE_JOBENFANCE,
    'RegieJd' => Calendar::REGIE_JOBDEPENDANCE 
  }
  
  # has_one :event_type, :foreign_key => 'fk_action'

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
      "locked"      =>  false }
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

