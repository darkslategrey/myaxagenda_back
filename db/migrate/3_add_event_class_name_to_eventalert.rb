class AddEventClassNameToEventalert < ActiveRecord::Migration
  def up
    add_column :event_alerts, :event_class_name, :string 
  end

  def down
    remove_column :event_alerts, :event_class_name
  end
end
