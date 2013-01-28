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

                 
  end

  def down
    drop_table :calendars
  end

end
