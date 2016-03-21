# This migration comes from kiosk (originally 20160312061234)
class CreateStatesTaxRatesJoin < ActiveRecord::Migration
  def up
    create_table :kiosk_states_tax_rates, id: false do |t|
    	t.integer :tax_rate_id
    	t.integer :state_id
    end
    add_index :kiosk_states_tax_rates, [:tax_rate_id, :state_id]
  end

  def down
  	drop_table :kiosk_states_tax_rates
  end
end
