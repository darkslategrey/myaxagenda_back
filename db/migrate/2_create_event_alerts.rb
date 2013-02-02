class CreateEventAlerts < ActiveRecord::Migration
  def up
    create_table :event_alerts do |t|
      t.integer :dol_ev_id
      t.string  :type_alert # email / popup
      t.integer :early
      t.string  :unit # minutes / jours
      t.text    :emails # list of emails
    end
  end

  def down
    drop_table :event_alerts
  end
end
