class DashboardsController < ApplicationController
	def manage_problems
		@problems = Problem.all
	end

	def manage_users
		@users = User.all
	end

	def manage_submissions
		@submissions = Submission.all
	end
end
