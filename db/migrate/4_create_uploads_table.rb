class CreateUploadsTable < ActiveRecord::Migration
  def up
    create_table :uploads do |t|
      t.string  :filepath
      t.integer :ev_id
      t.string  :classname
    end
  end

  def down
    drop_table :uploads
  end

end
