class DashboardsController < ApplicationController
	def manage_problems
		@problems = Problem.all
	end

	def manage_users
		@users = User.order(:score).reverse_order
	end

	def manage_submissions
		@submissions = Submission.all
	end
end
