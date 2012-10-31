class AddPhoneNoToSurfPreferences < ActiveRecord::Migration
  def change
    add_column :surf_preferences, :phone_no, :string
  end
end
