class AddUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :phone_no
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
