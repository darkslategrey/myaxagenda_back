class EventJd < Event
  establish_connection @@db_config['jobdependance']
  belongs_to :EventTypeJd, :class_name => "EventTypeJd"

end
