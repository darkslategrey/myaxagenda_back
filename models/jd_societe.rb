class JdSociete < JdDB
  self.table_name = 'llx_societe'
  
  has_many :events, :foreign_key => 'fk_soc', :class_name => 'EventJd', :inverse_of => :societe
end
