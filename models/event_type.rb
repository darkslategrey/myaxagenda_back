class EventType < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']

  logger    = Logger.new(STDOUT)
  ActiveRecord::Base.logger = logger

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_c_actioncomm'
  self.primary_key = 'id'

  # has_many :events, :foreign_key => 'fk_action', :class_name => 'Event'

  def self.get_regie_events
  end

end
