class EventType < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  logger    = Logger.new(STDOUT)
  ActiveRecord::Base.logger = logger

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_c_actioncomm'
  self.primary_key = 'id'

  # has_many :events, :foreign_key => 'fk_action', :class_name => 'Event'

  def self.regie_jobenfance
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    where('code = "AC_RJE"').first.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a
  end

  def self.regie_jobdependance
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    where('code = "AC_RJD"').first.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'").to_a
    # where('code = "AC_RJD"').first.events.to_a
  end

  def self.get_actions
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month

    actions = where(['code not in (?)',['AC_RJE', 'AC_RJD']]).to_a.map { |et|
      events = et.events.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'")
      events if events.size > 0 
    }.compact
    logger.debug("#{actions.size} actions found, class #{actions.class}")
    actions.to_a
  end

end
