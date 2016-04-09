require 'stripe'
require 'paperclip'
require 'jquery-rails'
require 'bcrypt'
require 'kiosk/state_importer'

module Kiosk

	class << self 

		def root
	      File.expand_path('../../', __FILE__)
	    end

	end
end

require "kiosk/engine"

