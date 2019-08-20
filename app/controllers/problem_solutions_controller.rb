require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
end

class ProblemSolutionsController < ApplicationController
    
    def new
        @sol = ProblemSolution.new
    end

    def create
        @sol = ProblemSolution.new(problem_solution_params)
        if @sol.save
            flash[:succ] = "Successfully created solution"
            redirect_to @sol
        else
            flash.now[:notice] = "Error creating solution"
        end
    end

    def show
        @markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
        @sol = ProblemSolution.find(params[:id])
    end

    def edit
        @sol = ProblemSolution.find(params[:id])
    end

    def update
        @sol = ProblemSolution.find(params[:id])
        @sol.update(problem_solution_params)
        @sol.save
        redirect_to @sol
    end

    def problem_solution_params
        params.require(:problem_solution).permit(:problem_id, :solution)
    end

    def destroy
        @sol = ProblemSolution.find(params[:id])
        @sol.destroy
        flash[:succ] = "Solution deleted"
        redirect_to "/dashboard/manage_problem_solutions"
    end

    def md_arguments
        {
            autolink: true,
            tables: true,
            autolink: true,
            fenced_code_blocks: true,
            lax_spacing: true,
            no_intra_emphasis: true,
            strikethrough: true,
            superscript: true
        }
    end

end
