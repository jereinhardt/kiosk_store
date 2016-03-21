require_dependency "kiosk/application_controller"

module Kiosk
  class TaxRatesController < ApplicationController

    before_action :authenticate_admin_user!
    
  	def index
  		@tax_rates = TaxRate.all
  	end

  	def new 
  		@tax_rate = TaxRate.new
  		@states = State.all
  	end

  	def create
  		@tax_rate = TaxRate.new(tax_rate_params)
  		if @tax_rate.save
  			redirect_to tax_rates_path, notice: 'New Tax Rate Created!'
  		else 
  			render 'new', alert: 'There was a problem'
  		end
  	end

  	def edit
  		@tax_rate = TaxRate.find(params[:id])
  		@states = State.all
  	end

  	def update
  		@tax_rate = TaxRate.find(params[:id])
  		if @tax_rate.update_attributes(tax_rate_params)
  			redirect_to tax_rates_path, notice: 'New Tax Rate Created!'
  		else
  			render 'edit', alert: 'There was a problem'
  		end
  	end

  	def destroy 
  		@tax_rate = TaxRate.find(params[:id])
  		if @tax_rate.destroy
  			redirect_to tax_rates_path, notice: 'Tax Rate Destroyed.'
  		else
  			render 'index', alert: "There was a problem."
  		end
  	end

  	private

  	def tax_rate_params
  		params.require(:tax_rate).permit(:rate, :applied_to_shipping_address, :applied_to_billing_address, :applied_to_shipping_cost, :state_ids => [] )
  	end

  end
end
