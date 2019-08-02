require 'json'

module UsersHelper
	def p_list
		@problems = Problem.all
		out = {}
		default = {
			:attempted => 0,
			:score => 0,
			:max_score => 0,
			:got_all_points => 0
		}
		@problems.each do |p|
			out[p.title] = default
		end
		return out.to_json
	end

	def update_users_problems
		@users = User.all
		@problems = Problem.all
		default = {
			:attempted => 0,
			:score => 0,
			:max_score => 0,
			:got_all_points => 0
		}
		@users.each do |user|

			if user.problem_list.nil?
				user.problem_list = p_list
			else
				list = JSON.parse(user.problem_list)
				@problems.each do |p|
					if !list.key?(p.title)
						list[p.title] = default
						list[p.title][:score] = p.score
					end
				end
				user.problem_list = list.to_json
			end
			user.save
		end
	end
end
