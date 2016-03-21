require_dependency "kiosk/application_controller"

module Kiosk
  class AdminUsersController < ApplicationController

    before_action :authenticate_admin_user!

  	def index
  		@users = AdminUser.all
  	end

  	def new
  		@user = AdminUser.new
  	end

  	def create
  		@user = AdminUser.create(user_params)
  		if @user.save
  			redirect_to admin_users_path, notice: 'New user created successfully!'
  		else
  			render 'new', alert: 'These seems to have been a problem'
  		end
  	end

  	def edit
  		@user = AdminUser.find(params[:id])
  	end

  	def update
  		@user = AdminUser.find(params[:id])
  		if @user.update_attributes(user_params)
  			redirect_to admin_users_path, notice: 'User updated successfully!'
  		else
  			render 'edit', alert: 'There was a problem updating this user'
  		end
  	end

  	def destroy
  		@user = AdminUser.find(params[:id])
  		if @user.destroy
  			redirect_to admin_users_path, notice: 'The user has been deleted.'
  		else
  			render 'index', alert: 'Unable to delete user at this time.  Please try again later.'
  		end
  	end

    private

    def user_params
      params.require(:admin_user).permit(:first_name, :last_name, :email, :password, :password_confiramtion)
    end
  	
  end
end
