class AddPermalinkToProductAndProductCategories < ActiveRecord::Migration
  def up
  	add_column :kiosk_products, :permalink, :string
  	add_column :kiosk_product_categories, :permalink, :string
  end

  def down
  	remove_column :kiosk_products, :permalink
  	remove_column :kiosk_product_categories, :permalink
  end
end
