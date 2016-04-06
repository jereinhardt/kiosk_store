module Kiosk
  class ShippingMethod < ActiveRecord::Base

  	validates :name, presence: true, uniqueness: true
  	validates :cost, presence: true, numericality: true

  	# returns a string with the name and cost of the shipping method
  	def display_name 
  		display_cost = number_to_currency cost
		return "#{name}: #{display_cost}"
	end

  end
end
