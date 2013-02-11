
class JeSociete < JeDB
  self.table_name = 'llx_societe'
  
  has_many :events, :foreign_key => 'fk_soc', :class_name => 'EventJe', :inverse_of => :societe
end
