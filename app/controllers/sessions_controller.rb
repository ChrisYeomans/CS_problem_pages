class SessionsController < ApplicationController
	def create
		@user = User.find_by(name: params[:session][:name])
		if @user && @user.authenticate(params[:session][:password])
			flash[:notice] = 'Successfully Logged in'
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
