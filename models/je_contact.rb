class JeContact < JeDB
  self.table_name = 'llx_socpeople'

  has_many :events, :foreign_key => 'fk_contact', :class_name => 'EventJe', :inverse_of => :contact
end
