class OrdersController < ApplicationController

	def index
		@order = current_order
	end 

	def checkout
	  @order = current_order

	  if request.post?
	  	if @order.confirm_order_params(order_params)
	  		redirect_to shipping_method_path(@order)
	  	else
	  		render 'checkout'
	  	end
	  end
	end

	def shipping
		@shipping_methods = Kiosk::ShippingMethod.all
		@order = current_order
		if params.include?(:order)
	      if @order.update_attributes(order_params)
	        redirect_to payment_path
	      else 
	        render 'shipping_method'
	      end
	    end
	end

	def payment 
		@order = current_order
	end

	def confirmation
	    @order = current_order

	    if request.post? && !@order.paid?
	    	if @order.accept_stripe_token(params[:stripeToken])
	    		redirect_to charge_path
	    	else 
	    		render 'confirmation'
	    	end
	    end
	end
	  
	def charge 
		@order = current_order
	    # Charge the Customer instead of the card
	    if @order.charge_customer
	    	session[:order_id] = nil
	    	redirect_to thanks_path
	    else
	    	render 'confirmation'
	    end
	end

	def thanks 
	end

	private

	def order_params
		params.require(:order).permit(:billing_name, :billing_phone_number, :billing_street_1, :billing_street_2, :billing_zip_code, :billing_city, :billing_email, :billing_state, :shipping_name, :shipping_phone_number, :shipping_street_1, :shipping_street_2, :shipping_zip_code, :shipping_city, :shipping_email, :shipping_state, :shipping_state_name, :shipping_method_id)
	end

end
