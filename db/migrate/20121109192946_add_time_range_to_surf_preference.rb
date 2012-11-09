class AddTimeRangeToSurfPreference < ActiveRecord::Migration
  def change
    add_column :surf_preferences, :start, :time
    add_column :surf_preferences, :end, :time
    add_column :surf_preferences, :last_contact, :datetime
  end
end
