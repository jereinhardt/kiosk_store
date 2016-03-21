# This migration comes from kiosk (originally 20160320171610)
class CreateKioskAdminUsers < ActiveRecord::Migration
  def up
  	create_table :kiosk_admin_users do |t|
  		t.string :first_name
  		t.string :last_name
  		t.string :email
  		t.string :password_digest
  		t.timestamps
  	end
  end

  def down
  	drop_table :kiosk_admin_users
  end
end
