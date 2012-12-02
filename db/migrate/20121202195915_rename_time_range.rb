class RenameTimeRange < ActiveRecord::Migration
  def up
    rename_column :surf_preferences, :start, :start_time
    rename_column :surf_preferences, :end, :end_time
  end

  def down
    rename_column :surf_preferences, :start_time, :start
    rename_column :surf_preferences, :end_time, :end
  end
end
