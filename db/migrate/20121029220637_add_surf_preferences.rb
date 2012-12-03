class AddSurfPreferences < ActiveRecord::Migration
  def up
    create_table :surf_preferences do |t|
      t.integer :max_size
      t.integer :min_size
      t.string :min_shape
      t.integer :spot_id
      t.timestamps
    end
  end
  
  def down
    drop_table :surf_preferences
  end
end
