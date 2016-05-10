module Kiosk
  class Order < ActiveRecord::Base

  	def confirm_order_params(params = {})
  		self.confirming!
  		if update(params)
  			self.confirming!
  			true
  		else
  			self.building!
  			false
  		end
  	end

	def accept_stripe_token(token)
		if !paid?
			if customer = Stripe::Customer.create(:source => token, :description => "customer for order number #{id}", id: id)
				self.paid!
				#save!
				true
			else
				false
			end
		end
	end

	def charge_customer
		if !confirmed?
			begin 
				charge = Stripe::Charge.create(amount: total_in_cents, currency: 'usd', customer: id, description: 'Charge for order #{id}')
				self.confirmed!
				#save! 
				true
			rescue => e 
				Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
			end
		end
	end

	def add_item(product, number=1)
		order_items.build(name: product.name, cost: product.price, quantity: number.to_i)
	end


  end
end