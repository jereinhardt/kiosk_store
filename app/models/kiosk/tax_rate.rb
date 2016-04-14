module Kiosk
  class TaxRate < ActiveRecord::Base
  	has_many :orders
  	has_and_belongs_to_many :states

  	validates :rate, presence: true, numericality: true


	# Return an array of state codes this tax rate applies to
	# state codes are two-digit strings, i.e. "KS" for Kansas
	def states_by_code 
		state_ids.map {|id| Kiosk::State.find(id).state_code}
	end

	# return an array of state names this tax rate applies to
	# this is an array of strings, i.e. ["Kansas", "Missouir", etc...]
	def states_by_name
		state_ids.map {|id| Kiosk::State.find(id).state_name}
	end

	# returns an array of state obects that this tax rate applies to
	# this is an array of objects, i.e. [<# Kiosk::State...#>, ...]
	def states
		state_ids.map {|id| Kiosk::State.find(id)}
	end 

  end
end
