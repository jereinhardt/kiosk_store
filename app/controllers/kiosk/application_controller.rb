module Kiosk
  class ApplicationController < ActionController::Base
  	protect_from_forgery

  	private

  	def current_admin_user
  		if session[:admin_id]
  			@current_admin_user ||= AdminUser.find(session[:admin_id])
  		end
  	end

  	def authenticate_admin_user!
  		redirect_to login_path unless current_admin_user
  	end

  	helper_method :current_admin_user
  end
end
