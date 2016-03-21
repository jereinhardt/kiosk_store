require_dependency "kiosk/application_controller"

module Kiosk
  class CustomersController < ApplicationController

    before_action :authenticate_admin_user!

  	def index
  		case params[:sort]
  		when 'oldest_first'
  			@customers = Customer.oldest_first
  		when 'newest_first' 
  			@customers = Customer.newest_first
  		else 
  			@customers = Customer.sort_by_name
  		end
  	end

    def new 
      @customer = Customer.new 
    end

    def create 
      @customer = Customer.create(customer_params)
      if @customer.save
        redirect_to customers_path, notice: 'New customer was created successfully!'
      else
        render 'new', alert: 'There was an issue creating customer.'
      end
    end

    def edit
      @customer = Customer.find(params[:id])
    end

    def update
      @customer = Customer.find(params[:id])
      if @customer.update_attributes(customer_params)
        redirect_to customers_path, notice: 'Customer profile was updated successfully!'
      else
        render 'new', alert: 'Opps!  Looks like something went wrong!'
      end
    end

    def show
      @customer = Customer.find(params[:id])
      @orders = @customer.orders
    end

  	def destroy
  		@customer = Customer.find(params[:id])
  		if @customer.destroy 
  			redirect_to customers_path, notice: 'Customer was successfully deleted.'
  		else
  			render 'index', alert: 'Unable to delete customer.'
  		end
  	end

    private 

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email)
    end
  end
end
