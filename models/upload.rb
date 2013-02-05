

class Upload < CalDB
  belongs_to :event_je, :foreign_key => 'ev_id', :class_name => 'EventJe'
  belongs_to :event_jd, :foreign_key => 'ev_id', :class_name => 'EventJd'
end
