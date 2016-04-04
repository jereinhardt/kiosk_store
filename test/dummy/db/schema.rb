# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160404051832) do

  create_table "kiosk_addresses", force: :cascade do |t|
    t.string   "name"
    t.string   "company"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "zip_code"
    t.string   "state"
    t.string   "country"
    t.string   "type"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "kiosk_addresses", ["customer_id"], name: "index_kiosk_addresses_on_customer_id"

  create_table "kiosk_admin_users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kiosk_customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kiosk_images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "product_id"
  end

  add_index "kiosk_images", ["product_id"], name: "index_kiosk_images_on_product_id"

  create_table "kiosk_order_items", force: :cascade do |t|
    t.string   "name"
    t.float    "cost"
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kiosk_order_items", ["order_id"], name: "index_kiosk_order_items_on_order_id"

  create_table "kiosk_orders", force: :cascade do |t|
    t.string   "billing_name"
    t.string   "billing_street_1"
    t.string   "billing_street_2"
    t.string   "billing_zip_code"
    t.string   "billing_state"
    t.string   "billing_country"
    t.string   "billing_email"
    t.string   "billing_phone_number"
    t.string   "shipping_name"
    t.string   "shipping_street_1"
    t.string   "shipping_street_2"
    t.string   "shipping_zip_code"
    t.string   "shipping_state"
    t.string   "shipping_country"
    t.string   "shipping_email"
    t.string   "shipping_phone_number"
    t.datetime "placed_at"
    t.datetime "shipped_at"
    t.integer  "customer_id"
    t.integer  "shipping_method_id"
    t.integer  "tax_rate_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "billing_street_3"
    t.string   "billing_city"
    t.string   "shipping_street_3"
    t.string   "shipping_city"
    t.string   "status"
  end

  add_index "kiosk_orders", ["customer_id"], name: "index_kiosk_orders_on_customer_id"
  add_index "kiosk_orders", ["shipping_method_id"], name: "index_kiosk_orders_on_shipping_method_id"
  add_index "kiosk_orders", ["tax_rate_id"], name: "index_kiosk_orders_on_tax_rate_id"

  create_table "kiosk_product_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "permalink"
  end

  create_table "kiosk_products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.float    "price"
    t.integer  "product_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "permalink"
    t.string   "short_description"
  end

  add_index "kiosk_products", ["product_category_id"], name: "index_kiosk_products_on_product_category_id"

  create_table "kiosk_shipping_methods", force: :cascade do |t|
    t.string   "name"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kiosk_states", force: :cascade do |t|
    t.string   "state_name"
    t.string   "state_code"
    t.text     "zip_codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kiosk_states_tax_rates", id: false, force: :cascade do |t|
    t.integer "tax_rate_id"
    t.integer "state_id"
  end

  add_index "kiosk_states_tax_rates", ["tax_rate_id", "state_id"], name: "index_kiosk_states_tax_rates_on_tax_rate_id_and_state_id"

  create_table "kiosk_tax_rates", force: :cascade do |t|
    t.float    "rate"
    t.boolean  "applied_to_shipping_cost"
    t.boolean  "applied_to_billing_address"
    t.boolean  "applied_to_shipping_address"
    t.text     "state_ids"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
