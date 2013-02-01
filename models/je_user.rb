class JeUser < JeDB
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'EventJe', :inverse_of => :user_asked
  has_many :events_done, :foreign_key => 'fk_user_done', :class_name => 'EventJe', :inverse_of => :user_done
  has_many :events_todo, :foreign_key => 'fk_user_action', :class_name => 'EventJe', :inverse_of => :user_todo

  def has_events?
    self.events_author.size > 0 and return true
    self.events_done.size > 0 and return true
    self.events_todo.size > 0 and return true
    return false
  end

end
