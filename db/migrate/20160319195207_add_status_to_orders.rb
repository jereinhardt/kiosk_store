class AddStatusToOrders < ActiveRecord::Migration
  def up
  	add_column :kiosk_orders, :status, :string
  end

  def down
  	remove_column :kiosk_orders, :status
  end
end
