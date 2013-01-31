class EventJe < JeDB
  include Event
  attr_accessor :cal_id
  # @cal_id = nil

  self.inheritance_column = "not_sti"
  self.table_name = 'llx_actioncomm'
  self.primary_key = 'id'

  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventTypeJe', :inverse_of => :events

  # fk_user_author / userasked
  # fk_user_done / userdone
  # fk_user_action / usertodo

  belongs_to :user_asked, :foreign_key => 'fk_user_author', :class_name => 'JeUser', :inverse_of => :events_author
  belongs_to :user_done, :foreign_key => 'fk_user_done', :class_name => 'JeUser', :inverse_of => :events_done
  belongs_to :user_todo, :foreign_key => 'fk_user_action', :class_name => 'JeUser', :inverse_of => :events_todo

end


