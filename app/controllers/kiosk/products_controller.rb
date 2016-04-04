require_dependency "kiosk/application_controller"

module Kiosk
  class ProductsController < ApplicationController

    before_action :authenticate_admin_user!

  	def index 
  		@products = Product.all
  		@categories = ProductCategory.all
  	end

  	def new 
  		@product = Product.new
  	end

  	def create
      if params[:product][:product_category_id] != ""
        @product = ProductCategory.find(params[:product][:product_category_id]).products.build(product_params)
      else 
  		  @product = Product.create(product_params)
      end
  		@product.images.build(product_image_params)
  		if @product.save!
  			redirect_to products_path, notice: 'New product added!'
  		else 
  			render 'new', alert: 'Oops!  Something went wrong!'
  		end
  	end

  	def edit
  		@product = Product.find(params[:id])
  	end

  	def update
  		@product = Product.find(params[:id])
  		if params[:product][:image]
  			@product.images.build(product_image_params)
  		end
  		if @product.update_attributes(product_params)
			redirect_to edit_product_path(@product), notice: 'Product updated!'
  		else 
  			render 'new', alert: 'Oops!  Something went wrong!'
  		end
  	end

  	def destroy 
  		@product = Product.find(params[:id])
  		if @product.destroy
  			redirect_to products_path, notice: 'Product deleted!'
  		else
   			render 'new', alert: 'Oops!  Something went wrong!'
		end
	end

  	private

  	def product_params
  		params.require(:product).permit(:name, :price, :stock, :short_description, :description, :permalink)
  	end

  	def product_image_params
  		params.require(:product).permit(:image)
  	end

  end
end
