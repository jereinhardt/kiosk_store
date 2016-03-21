class ProductsController < ApplicationController

	before_action :check_for_current_order

	def index 
		@products = Kiosk::Product.all 
	end

	def buy
		@product = Kiosk::Product.find(params[:id])
		current_order.order_items.add_item(@product, params[:quantity])
		redirect_to product_path(@product)
	end

	def show
		@product = Kiosk::Product.find(params[:id])
	end


end
