class ProblemsController < ApplicationController
  def index
  end

  def past_problems
    @problems = Problem.all
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(params.require(:problem).permit(:title, :body, :test_cases, :is_current))
    @problem.save
    redirect_to @problem
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.save
    redirect_to @problem
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    redirect_to problems_path
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  # Controls logged admin with a session, one password
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