class SessionsController < ApplicationController
	
	# called by /login post. Authenticates the user
	# and the gives the user their session to keep them
	# logged in
	def create
		@user = User.find_by(name: params[:session][:name])
		if @user && @user.authenticate(params[:session][:password])
			flash[:succ] = 'Successfully Logged in'
			log_in @user # log_in is located in session_helper
			redirect_to @user
		else
			flash[:notice] = 'Invalid username/password combination'
			redirect_to '/login'
		end
	end

	def destroy
		session.clear
		flash[:succ] = "Logged out"
		redirect_to root_url
	end
end
