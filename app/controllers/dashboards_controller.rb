class DashboardsController < ApplicationController
	def manage_problems
		@problems = Problem.all
	end

	def manage_users
		@users = User.all
	end
end
