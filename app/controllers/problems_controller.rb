require 'digest/sha2'

class ProblemsController < ApplicationController
  def index
  end

  def past_problems
    @problems = Problem.all
  end

  def current_problem
    @problems = Problem.all
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(problem_params)
    @problem.save
    redirect_to @problem
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.update(problem_params)
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
  def enter_back_in
    if session[:admin]
      redirect_to root_url
  	elsif Digest::SHA256.new << params[:password] == "3cb1b9f7a3bc532712b7597206ed4ab6c3d5db6fe09dba41e600be3883057fab"
  		# current pw is CTistherealT
      session.clear
  		session[:admin] = true
  		redirect_to root_url
  	else
  		redirect_to "/back_in"
  	end
  end

  # When someone goes to www.site/logout the session
  # is cleared and they are put back to the home page.
  def back_out
  	session.clear
  	redirect_to root_url
  end


  # some post modification methods
  def make_past
    @problem = Problem.find(params[:id])
    @problem.is_hidden = false
    @problem.save
    redirect_to "/dashboard/manage_problems"
  end

  def make_current
    Problem.all.each do |p|
      p.is_current = false
      p.save
    end
    @problem = Problem.find(params[:id])
    @problem.is_current = true
    @problem.save
    redirect_to "/dashboard/manage_problems"
  end

  def make_not_current
    @problem = Problem.find(params[:id])
    @problem.is_current = false
    @problem.save
    redirect_to "/dashboard/manage_problems"
  end

  def make_hidden
    @problem = Problem.find(params[:id])
    @problem.is_hidden = true
    @problem.save
    redirect_to "/dashboard/manage_problems"
  end

  def problem_params
    params.require(:problem).permit(:title, :body, :test_cases, :is_current, :is_hidden)
  end
end