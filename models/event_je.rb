class EventJe < Event
  @@cal_id = Calendar::ACTIONS_JOBENFANCE

  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventTypeJe'
end


