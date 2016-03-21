# This migration comes from kiosk (originally 20160319195207)
class AddStatusToOrders < ActiveRecord::Migration
  def up
  	add_column :kiosk_orders, :status, :string
  end

  def down
  	remove_column :kiosk_orders, :status
  end
end
