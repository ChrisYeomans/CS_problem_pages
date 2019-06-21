class ProblemsController < ApplicationController
  def index
  end

  def past_problems
    @problems = Problem.all
  end

  def show
    @problem = Problem.find(params[:id])
  end

  # Controls logged users with a session, one password
  # will add hashing later
  def new_login
    if session[:auth]
      redirect_to root_url
  	elsif params[:password] == "1234"
  		session.clear
  		session[:auth] = true
  		redirect_to root_url
  	else
  		redirect_to "/login"
  	end
  end

  # When someone goes to www.site/logout the session
  # is cleared and they are put back to the home page.
  def logout
  	session.clear
  	redirect_to root_url
  end
end