class EventJd < Event
  establish_connection @@db_config['jobdependance']
  # belongs_to :EventTypeJd, :class_name => "EventTypeJd", :inverse_of => :events
  has_one :event_type, :foreign_key => 'fk_action', :class_name => 'EventTypeJd', :inverse_of => :events

end
