module Kiosk
  module ApplicationHelper

  	def render_order_details(obj, num)
  		i = 0
  		new_string = ""
  		while i < num 
  			new_string += "#{obj.order_items[i].name} - price: #{obj.order_items[i].cost} - quantity: #{obj.order_items[i].quantity} <br /> "
  			i += 1
  		end
  		return new_string
	end

	def readable_date(date)
		return date.strftime("%m/%d/%Y")
	end

  def include_partial
    render partial: 'layouts/kiosk/test_partial'
  end

  end
end
