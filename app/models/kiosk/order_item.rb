module Kiosk
  class OrderItem < ActiveRecord::Base

  	belongs_to :order

  	# returns the float value of the total of the order item
	def total
		(cost.to_f * quantity.to_f).to_f 
	end

	def images 
		Kiosk::Product.find_by(name: name).images
	end

	#method to add item to basket based on product and quantity
	def self.add_item(product, number=1)
		new_item = create(name: product.name, cost: product.price, quantity: number.to_i)
		new_item
	end

  end
end
