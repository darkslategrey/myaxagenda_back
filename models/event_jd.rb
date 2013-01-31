class EventJd < Event
  establish_connection @@db_config['jobdependance']
  # belongs_to :EventTypeJd, :class_name => "EventTypeJd", :inverse_of => :events
  belongs_to :event_type, :foreign_key => 'fk_action', :class_name => 'EventTypeJd', :inverse_of => :events


  # fk_user_author / userasked
  # fk_user_done / userdone
  # fk_user_action / usertodo
  belongs_to :user_asked, :foreign_key => 'fk_user_author', :class_name => 'JdUser', :inverse_of => :events_author
  belongs_to :user_done, :foreign_key => 'fk_user_done', :class_name => 'JdUser', :inverse_of => :events_done
  belongs_to :user_todo, :foreign_key => 'fk_user_action', :class_name => 'JdUser', :inverse_of => :events_todo

end
