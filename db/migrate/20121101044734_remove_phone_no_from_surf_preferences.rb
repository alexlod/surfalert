class RemovePhoneNoFromSurfPreferences < ActiveRecord::Migration
  def change
    remove_column :surf_preferences, :phone_no
  end
end
