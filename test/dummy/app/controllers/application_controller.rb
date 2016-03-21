class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	  def current_order
	    check_for_current_order
	  	@order ||= Kiosk::Order.find(session[:order_id])
	  end

	  def check_for_current_order
		unless session[:order_id]
			@order = Kiosk::Order.create
			session[:order_id] = @order.id
	    end
	  end
  
  helper_method :current_order, :check_for_current_order


end
