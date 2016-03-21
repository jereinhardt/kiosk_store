module Kiosk
  module OrdersHelper

  	def stripe_form_helper
  		render partial: "kiosk/orders/stripe_form_helper"
  	end
  	
  end
end
