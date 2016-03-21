require_dependency "kiosk/application_controller"

module Kiosk
  class ProductCategoriesController < ApplicationController

    before_action :authenticate_admin_user!

  	def index 
  		@categories = ProductCategory.all 
  	end

  	def new 
  		@category = ProductCategory.new
  	end

  	def create
  		@category =  ProductCategory.create(category_params)
  		if @category.save
  			redirect_to product_categories_path, notice: 'New category created successfully!'
  		else
  			render 'new', alert: 'There was a problem!'
  		end
  	end

  	def show 
  		@category = ProductCategory.find(params[:id])
  		@products = @category.products
  	end

  	def edit
  		@category = ProductCategory.find(params[:id])
	  end  		

  	def update
  		@category = ProductCategory.find(params[:id])
  		if @category.update_attributes(category_params)
  			redirect_to product_categories_path, notice: 'New category updated successfully!'
  		else
  			render 'new', alert: 'There was a problem!'
  		end
  	end

    def destroy
      @category = ProductCategory.find(params[:id])
      if @category.destroy
        redirect_to product_categories_path, notice: "Category was deleted."
      else
        render 'index', alert: "There was a problem!"
      end
    end
    

  	private 

  	def category_params
  		params.require(:product_category).permit(:name, :description, :permalink)
  	end

  end
end
