class ChagneDecimalsToFloat < ActiveRecord::Migration
  def up
  	change_column :kiosk_order_items, :cost, :float
  	change_column :kiosk_products, :price, :float
  	change_column :kiosk_shipping_methods, :cost, :float
  	change_column :kiosk_tax_rates, :rate, :float
  end
end
