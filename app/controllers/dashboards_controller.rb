class DashboardsController < ApplicationController
	def index
	end

	def manage_problems
		@problems = Problem.all
	end

	def edit_problem
		
	end

	def delete_problem

	end
end
