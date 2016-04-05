class AddBillingCompanyAndShippingCompanyToOrders < ActiveRecord::Migration
  def up
  	add_column :kiosk_orders, :billing_company, :string
  	add_column :kiosk_orders, :shipping_company, :string
  end

  def down
  	remove_column :kiosk_orders, :billing_company
  	remove_column :kiosk_orders, :shipping_company
  end
end
