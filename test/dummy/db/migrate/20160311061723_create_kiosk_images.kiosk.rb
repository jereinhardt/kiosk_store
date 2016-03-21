# This migration comes from kiosk (originally 20160311061415)
class CreateKioskImages < ActiveRecord::Migration
  def up
    create_table :kiosk_images do |t|
    	t.attachment :image 
    	t.integer :product_id
    end
    add_index :kiosk_images, :product_id
  end

  def down
  	drop_table :kiosk_images
  end
end
