module Kiosk
  class State < ActiveRecord::Base
  	has_and_belongs_to_many :tax_rates

  	scope :sorted, -> { order(state_name: :asc)}

  	# returns an array every zip code that belongs to a single state
  	# the zip codes are stored as strings, not integers
  	def zip_code_list
		zip_codes.split(" ")
	end

  end
end
