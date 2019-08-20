class DashboardsController < ApplicationController

	def update_user_table
		@users = User.order(:score).reverse_order
		respond_to do |format|
			format.js {}
		end
	end

	def update_problem_table
		@problems = Problem.all
		respond_to do |format|
			format.js {}
		end
	end

	def update_submission_table
		@submissions = Submission.all
		respond_to do |format|
			format.js {}
		end
	end

	def update_solution_table
		@sols = ProblemSolution.all
		respond_to do |format|
			format.js {}
		end
	end

end
