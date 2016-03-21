require_dependency "kiosk/application_controller"

module Kiosk
  class OrdersController < ApplicationController

    before_action :authenticate_admin_user!
    
  	def index
  		@orders = Order.placed
  	end

  	def show
  		@order = Order.find(params[:id])
  	end

  	def shipped
  		@order = Order.find(params[:id])
  		@order.shipped!
  		redirect_to order_path(@order), notice: "This item was marked as shipped: #{Time.now.strftime("%m/%d/%Y")}"
  		# else
  		# 	render 'show', flash[:alert] = "This item was unable to be marked as shipped."
  		# end
  	end



  end
end
