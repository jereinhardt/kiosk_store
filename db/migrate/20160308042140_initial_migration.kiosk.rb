# This migration comes from kiosk (originally 20160307065750)
class InitialMigration < ActiveRecord::Migration
  def up
  	create_table :kiosk_states do |t|
  	  t.string :state_name
      t.string :state_code
      t.text :zip_codes

      t.timestamps null: false
    end

    create_table :kiosk_customers do |t|
        t.string :first_name
        t.string :last_name
        t.string :email

        t.timestamps null: false
    end

    create_table :kiosk_addresses do |t|
    	t.string :name
    	t.string :company
    	t.string :street_1
    	t.string :street_2
    	t.string :zip_code
    	t.string :state
    	t.string :country
    	t.string :type
        #t.references :customer, index: true, foreign_key: true

    	t.timestamps null: false
    end

    create_table :kiosk_shipping_methods do |t|
        t.string :name
        t.decimal :cost

        t.timestamps null: false
    end

    create_table :kiosk_tax_rates do |t|
        t.decimal :rate
        t.boolean :applied_to_shipping_cost
        t.boolean :applied_to_billing_address
        t.boolean :applied_to_shipping_address
        t.text :state_ids

        t.timestamps null: false
    end 

    create_table :kiosk_orders do |t|
    	t.string :billing_name
    	t.string :billing_street_1
    	t.string :billing_street_2
    	t.string :billing_zip_code
    	t.string :billing_state
    	t.string :billing_country
    	t.string :billing_email
    	t.string :billing_phone_number

    	t.string :shipping_name
    	t.string :shipping_street_1
    	t.string :shipping_street_2
    	t.string :shipping_zip_code
    	t.string :shipping_state
    	t.string :shipping_country
    	t.string :shipping_email
    	t.string :shipping_phone_number

    	t.datetime :placed_at
    	t.datetime :shipped_at

        # t.references :customer, index: true, foreign_key: true
        t.references :shipping_method, index: true, foreign_key: true
        t.references :tax_rate, index: true, foreign_key: true

    	t.timestamps null: false
    end

    create_table :kiosk_order_items do |t|
    	t.string :name
    	t.decimal :cost 
    	t.integer :quantity

        t.references :order, index: true, foreign_key: true

    	t.timestamps null: false
    end

    create_table :kiosk_product_categories do |t|
        t.string :name 
        t.text :description

        t.timestamps null: false
    end

    create_table :kiosk_products do |t|
    	t.string :name
    	t.text :description
    	t.integer :stock
    	t.decimal :price

        t.references :product_category, index: true, foreign_key: true

    	t.timestamps null: false
    end
  end

  def down
  	[:states, :addresses, :customers, :orders, :order_items, :products, :product_categories, :shipping_methods, :tax_rates].each do |table|
  		drop_table "kiosk_#{table}"
  	end
  end

end
