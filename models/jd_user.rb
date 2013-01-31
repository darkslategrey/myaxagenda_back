
class JdUser < JdDB
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'EventJd', :inverse_of => :user_asked
  has_many :events_done, :foreign_key => 'fk_user_done', :class_name => 'EventJd', :inverse_of => :user_done
  has_many :events_todo, :foreign_key => 'fk_user_action', :class_name => 'EventJd', :inverse_of => :user_todo

end
