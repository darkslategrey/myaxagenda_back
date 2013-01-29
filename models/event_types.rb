class EventType < ActiveRecord::Base

  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  @@mylogger    = Logger.new(STDOUT)
  # ActiveRecord::Base.logger = @@logger

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_c_actioncomm'
  self.primary_key = 'id'

  # to be able to set ids
  attr_accessible :id, :code, :type, :libelle, :module, :active, :todo, :position

end


class EventTypeJe < EventType
  has_many :events, :foreign_key => 'fk_action', :class_name => 'EventJe', :inverse_of => :event_type
  # has_many :regies, :foreign_key => 'fk_action', :class_name => 'EventJe', :conditions => 'code = "AC_RJE"'

  def self.get_actions(params={})
    return [] if Calendar.find(Calendar::ACTIONS_JOBENFANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    actions = []
    ev_types = EventTypeJe.where('code != "AC_REGIE"')
    @@mylogger.debug("JE get action EVENT TYOE <#{ev_types}>")
    if not ev_types.nil?
      actions = ev_types.to_a.map { |et|
        events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'") || []
        events # if events.size > 0 
      }.compact
    end
    @@mylogger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a.flatten.map { |e| e.cal_id = Calendar::ACTIONS_JOBENFANCE }
    actions.to_a.flatten
  end

  def self.get_regies(params={})
    return [] if Calendar.find(Calendar::REGIE_JOBENFANCE).hide
    regies = []
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    
    ev_type = EventTypeJe.where('code = "AC_REGIE"').first
    @@mylogger.debug("JE get regie EVENT TYOE <#{ev_type}>")
    if not ev_type.nil?
      events = ev_type.events
    end
    if not events.nil?
      regies = events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a.flatten || []
    end
    regies.map { |e| e.cal_id = Calendar::REGIE_JOBENFANCE } 
    @@mylogger.debug("#{self.base_class}: nbr de regies: #{regies.size}")
    regies.to_a.flatten 
  end
end

class EventTypeJd < EventType
  establish_connection @@db_config['jobdependance']
  has_many :events, :foreign_key => 'fk_action', :class_name => 'EventJd', :inverse_of => :event_type


  def self.get_actions(params={})
    return [] if Calendar.find(Calendar::ACTIONS_JOBDEPENDANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    actions = []
    ev_types = EventTypeJd.where('code != "AC_REGIE"')
    @@mylogger.debug("JD get action EVENT TYOE <#{ev_types}>")
    if not ev_types.nil?
      actions = ev_types.to_a.map { |et|
        events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'") || []
        events # if events.size > 0 
      }.compact
    end
    @@mylogger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a.flatten.map { |e| e.cal_id = Calendar::ACTIONS_JOBDEPENDANCE }
    actions.to_a.flatten
  end


  def self.get_regies(params={})
    return [] if Calendar.find(Calendar::REGIE_JOBDEPENDANCE).hide
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
    regies.map { |e| e.cal_id = Calendar::REGIE_JOBDEPENDANCE } 
    @@mylogger.debug("#{self.base_class}: nbr de regies: #{regies.size}")
    regies.to_a.flatten 
  end

end
