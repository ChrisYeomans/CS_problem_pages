class ProblemsController < ApplicationController
  def index
  end
  def new_login
  	if params[:password] == "1234"
  		session.clear
  		session[:user_id] = 1234
  		redirect_to root_url
  	else
  		redirect_to "/login"
  	end
  end
  def logout
  	session.clear
  	redirect_to root_url
  end
end
