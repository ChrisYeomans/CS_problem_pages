require 'redcarpet'

class ProblemsController < ApplicationController
  def past_problems
    @problems = Problem.all
  end

  # The page for this loops through all the problems until
  # it find one with is_current == 1. There should only be
  # one problem like this
  def current_problem
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @problems = Problem.all
  end

  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(problem_params)

    if @problem.save
      # if its current we need to make all other problems not current
      if @problem.is_current
        Problem.all.each do |p|
          if p.id != @problem.id
            p.is_current = 0 
            p.save
          end
        end
      end

      flash[:succ] = "Problem Created"
      redirect_to @problem
    else
      render '/dashboards/create_problem'
    end
  end

  # edit just gives the :patch the info then
  # update is called with the :post
  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.update(problem_params)
    @problem.save
    flash[:succ] = "Problem updated successfully"
    redirect_to @problem
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy
    flash[:succ] = "Problem deleted"
    redirect_to problems_path
  end


  # some post modification methods
  def make_past # make visible/make not hidden
    @problem = Problem.find(params[:id])
    @problem.is_hidden = false
    @problem.save
    flash[:succ] = "Problem is now visible"
    redirect_to "/dashboard/manage_problems"
  end

  def make_current
    # need to make all other problems not current
    Problem.all.each do |p|
      p.is_current = false
      p.save
    end
    @problem = Problem.find(params[:id])
    @problem.is_current = true
    @problem.save
    flash[:succ] = "Problem is now the problem of the week"
    redirect_to "/dashboard/manage_problems"
  end

  def make_not_current
    @problem = Problem.find(params[:id])
    @problem.is_current = false
    @problem.save
    flash[:succ] = "Problem is now not the problem of the week"
    redirect_to "/dashboard/manage_problems"
  end

  def make_hidden
    @problem = Problem.find(params[:id])
    @problem.is_hidden = true
    @problem.save
    flash[:succ] = "Problem is now hidden"
    redirect_to "/dashboard/manage_problems"
  end

  def problem_params
    params.require(:problem).permit(:title, :body, :test_cases, :is_current, :is_hidden)
  end

end