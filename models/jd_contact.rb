class JdContact < JdDB
  self.table_name = 'llx_socpeople'

  has_many :events, :foreign_key => 'fk_contact', :class_name => 'EventJd', :inverse_of => :contact
end
