class CreateAddressCities < ActiveRecord::Migration
  def up
  	add_column :kiosk_orders, :billing_street_3, :string, after: :billing_street_2
    add_column :kiosk_orders, :billing_city, :string, after: :billing_street_3

    add_column :kiosk_orders, :shipping_street_3, :string, after: :shipping_street_2
    add_column :kiosk_orders, :shipping_city, :string, after: :shipping_street_3
  end
end
