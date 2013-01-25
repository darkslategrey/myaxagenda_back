class EventTypeJe < EventType
  establish_connection @@db_config['jobenfance']
  has_many :events, :class_name => "EventJe", :foreign_key => 'fk_action'
end



