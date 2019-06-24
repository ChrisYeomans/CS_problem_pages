require 'digest/sha2'

class SessionsController < ApplicationController
	def create
		@user = User.find_by(name: params[:session][:name])
		if @user && Digest::SHA256.new << params[:session][:password] == @user.password
			log_in @user
			redirect_to @user
		else
			flash[:notice] = 'Invalid username/password combination'
			redirect_to '/login'
		end
	end
	def destroy
		session.clear
		redirect_to root_url
	end
end
