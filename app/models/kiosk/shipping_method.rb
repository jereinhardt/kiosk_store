module Kiosk
  class ShippingMethod < ActiveRecord::Base

  	validates :name, presence: true, uniqueness: true
  	validates :cost, presence: true, numericality: true

  	# returns a string with the name and cost of the shipping method
  	def display_name 
		"#{name}: #{cost}"
	end

  end
end
