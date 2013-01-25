class EventTypeJd < EventType
  establish_connection @@db_config['jobdependance']
  has_many :events, :class_name => "EventJd", :foreign_key => 'fk_action'
end

