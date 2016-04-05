class AddBillingAndShippingCityToOrders < ActiveRecord::Migration
  def up
  	add_column :kiosk_orders, :billing_city, :string
  	add_column :kiosk_orders, :shipping_city, :string
  end

  def down
  	remove_column :kiosk_orders, :billing_city
  	remove_column :kiosk_orders, :shipping_city
  end
end
