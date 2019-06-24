require 'digest/sha2'

class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
    render 'past_problems'
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

    if @problem.save
      redirect_to @problem
    else
      render '/dashboards/create_problem'
    end
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