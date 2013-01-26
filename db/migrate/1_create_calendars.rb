# -*- coding: utf-8 -*-
class CreateCalendars < ActiveRecord::Migration
  def up
    create_table :calendars do |t|
      t.integer :id
      t.string  :name
      t.string  :code
      t.string  :description
      t.string  :color
      t.boolean :hide, :default => false
    end

    Calendar.create(:name => 'Régie Jobenfance',
                    :code => 'REGIE_JOBENFANCE',
                    :description => 'Régie Jobenfance',
                    :color => '')
    Calendar.create(:name => 'Régie Jobdependance',
                    :code => 'REGIE_JOBDEPENDANCE',
                    :description => 'Régie Jobdependance',
                    :color => '')
    Calendar.create(:name => 'Actions Jobenfance',
                    :code => 'ACTIONS_JOBENFANCE',
                    :description => 'Régie Jobenfance',
                    :color => '')
    Calendar.create(:name => 'Actions Jobdependance',
                    :code => 'ACTIONS_JOBDEPENDANCE',
                    :description => 'Régie Jobdependance',
                    :color => '')
                 
  end

  def down
    drop_table :calendars
  end

end
