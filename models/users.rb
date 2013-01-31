class JeUser < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobenfance']
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'EventJe', :inverse_of => :user_asked
  has_many :events_done, :foreign_key => 'fk_user_done', :class_name => 'EventJe', :inverse_of => :user_done
  has_many :events_todo, :foreign_key => 'fk_user_action', :class_name => 'EventJe', :inverse_of => :user_todo
end

class JdUser < ActiveRecord::Base
  @@db_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/databases.yml'))
  establish_connection @@db_config['jobdependance']
  self.table_name = 'llx_user'

  has_many :events_author, :foreign_key => 'fk_user_author', :class_name => 'EventJd', :inverse_of => :user_asked
  has_many :events_done, :foreign_key => 'fk_user_done', :class_name => 'EventJd', :inverse_of => :user_done
  has_many :events_todo, :foreign_key => 'fk_user_action', :class_name => 'EventJd', :inverse_of => :user_todo

end
