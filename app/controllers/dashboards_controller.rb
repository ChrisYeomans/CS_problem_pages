class DashboardsController < ApplicationController
	def index
	end

	def manage_problems
		@problems = Problem.all
	end

	def add_problem_to_database
		@problem = Problem.new(params.require(:problem).permit(:title, :body, :test_cases, :is_current))
		@problem.save
		redirect_to @problem
	end
end
