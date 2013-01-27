class EventJd < Event
  establish_connection @@db_config['jobdependance']
  # belongs_to :EventTypeJd, :class_name => "EventTypeJd"
  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventTypeJd'

end
