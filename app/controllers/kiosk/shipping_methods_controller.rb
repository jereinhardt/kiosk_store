require_dependency "kiosk/application_controller"

module Kiosk
  class ShippingMethodsController < ApplicationController

    before_action :authenticate_admin_user!

  	def index
  		@shipping_methods = ShippingMethod.all
  	end

  	def new 
  		@shipping_method = ShippingMethod.new
  	end

  	def create
  		@shipping_method = ShippingMethod.create(shipping_method_params)
  		if @shipping_method.save
  			redirect_to shipping_methods_path, notice: 'New shipping method created!'
  		else
  			render 'new', alert: 'There was a problem'
  		end
  	end

  	def edit
  		@shipping_method = ShippingMethod.find(params[:id])
  	end

  	def update
  		@shipping_method = ShippingMethod.find(params[:id])
  		if @shipping_method.update_attributes(shipping_method_params)
  			redirect_to shipping_methods_path, notice: 'New shipping method created!'
  		else
  			render 'edit', alert: 'There was a problem!'
  		end
  	end

    def destroy 
      @shipping_method = ShippingMethod.find(params[:id])
      if @shipping_method.destroy
        redirect_to shipping_methods_path, notice: 'Shipping method destroyed.'
      else
        render 'index', alert: 'There was a problem'
      end
    end
    

  	private

  	def shipping_method_params
  		params.require(:shipping_method).permit(:name, :cost)
  	end

  end
end
