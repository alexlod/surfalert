class AddUserIdToSurfPreferences < ActiveRecord::Migration
  def change
    add_column :surf_preferences, :user_id, :integer
  end
end
