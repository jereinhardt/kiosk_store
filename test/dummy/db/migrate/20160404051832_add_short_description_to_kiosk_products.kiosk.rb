# This migration comes from kiosk (originally 20160404051605)
class AddShortDescriptionToKioskProducts < ActiveRecord::Migration
  def up
  	add_column :kiosk_products, :short_description, :string
  end

  def down
  	remove_column :kiosk_products, :short_description
  end
  
end
