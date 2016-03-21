require_dependency "kiosk/application_controller"

module Kiosk
  class SessionsController < ApplicationController

  	def new
      render layout: 'layouts/kiosk/login'
  	end

  	def create
  		user = AdminUser.find_by(email: params[:email])
  		if user && user.authenticate(params[:password])
  			session[:admin_id] = user.id
  			redirect_to root_url
  		else
        flash.alert = "Invalid email or password"
  			render 'new', layout: 'layouts/kiosk/login'
  		end
  	end

  	def destroy
  		session[:admin_id] = nil
  		redirect_to root_url, notice: 'Logout successful!'
  	end
  end
end
