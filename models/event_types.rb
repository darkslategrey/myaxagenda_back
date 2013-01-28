class EventType < ActiveRecord::Base

  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  @@logger    = Logger.new(STDOUT)
  # ActiveRecord::Base.logger = @@logger

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_c_actioncomm'
  self.primary_key = 'id'

  # to be able to set ids
  attr_accessible :id, :code, :type, :libelle, :module, :active, :todo, :position

end


class EventTypeJe < EventType
  has_many :events, :foreign_key => 'fk_action', :class_name => 'EventJe'
  # has_many :regies, :foreign_key => 'fk_action', :class_name => 'EventJe', :conditions => 'code = "AC_RJE"'

  def self.get_actions
    return [] if Calendar.find(Calendar::ACTIONS_JOBENFANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    actions = where(['code not in (?)',['AC_RJE', 'AC_RJD']]).to_a.map { |et|
      events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'")
      events if events.size > 0 
    }.compact
    logger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a.flatten.map { |e| e.cal_id = Calendar::ACTIONS_JOBENFANCE }
    actions.to_a.flatten
  end

  def self.get_regies
    return [] if Calendar.find(Calendar::REGIE_JOBENFANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    regies = where('code = "AC_RJE"').first.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a.flatten
    regies.map { |e| e.cal_id = Calendar::REGIE_JOBENFANCE }
    regies.to_a.flatten
  end

end

class EventTypeJd < EventType
  establish_connection @@db_config['jobdependance']
  has_many :events, :foreign_key => 'fk_action', :class_name => 'EventJd'

  def self.get_actions
    return [] if Calendar.find(Calendar::ACTIONS_JOBDEPENDANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    actions = where(['code not in (?)',['AC_RJE', 'AC_RJD']]).to_a.map { |et|
      events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'")
      events if events.size > 0 
    }.compact
    logger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a.flatten.map { |e| e.cal_id = Calendar::ACTIONS_JOBDEPENDANCE }
    actions.to_a.flatten
  end

  def self.get_regies
    return [] if Calendar.find(Calendar::REGIE_JOBDEPENDANCE).hide
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    regies = where('code = "AC_RJD"').first.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a.flatten
    regies.map { |e| e.cal_id = Calendar::REGIE_JOBDEPENDANCE }
    regies.to_a.flatten
  end

end
