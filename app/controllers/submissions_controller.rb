require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'json'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class SubmissionsController < ApplicationController
	include SubmissionsHelper

	def index
		render "new"
	end

	def show
		@submission = Submission.find(params[:id])
		@problem = Problem.find(@submission.problem_id)
		@markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
	end

	def create
		@submission = Submission.new(submission_params_with_problem_id)
		if not params[:submission][:upload].nil?
			@submission.code = params[:submission][:upload].read
		end
		@submission.user_id = current_user.id
		@user = User.find(@submission.user_id)
		@problem = Problem.find(@submission.problem_id)
		@submission.extension = get_extension(@submission.language)

		flash[:succ] = "Submitted please wait then reload to update results"
		if @submission.save
			Thread.new do
				@submission.test_cases_passed, @submission.results = test_cases(@submission.language, @submission.id, @problem.test_cases, use_lrun=true, max_cpu_time=@problem.cpu_time, max_memory=@problem.memory)
				@submission.verdict = (@submission.test_cases_passed == @problem.number_of_test_cases)
				@submission.save

				score = ((@submission.test_cases_passed/@problem.number_of_test_cases)*@problem.score).floor
				
				# need to update user problem_list
				# to reflect what happened
				lst = JSON.parse(@user.problem_list)
				if lst[@problem.title]["attempted"] == 0
					@problem.users_attempted += 1
				end
				lst[@problem.title]["attempted"] += 1
				past_score = lst[@problem.title]["score"]
				if past_score < score
					lst[@problem.title]["score"] = score
					@user.score -= past_score
					@user.score += score
					@problem.total_user_score -= past_score
					@problem.total_user_score += score
				end
				lst[@problem.title]["got_all_points"] = @submission.verdict
				@user.problem_list = lst.to_json
				@problem.save
				@user.save
			end

			redirect_to @submission
		else
			flash[:notice] = "Error in submitting"
			redirect_to @submission
		end
	end

	def edit
		@submission = Submission.find(params[:id])
	end

	def update
		@submission = Submission.find(params[:id])
		@submission.update(submission_params)
		@submission.extension = get_extension(@submission.language)
		@submission.save
		resubmit
	end

	def destroy
		@submission = Submission.find(params[:id])
		@submission.destroy
		flash[:succ] = "Submission Destroyed"
		redirect_to "/dashboard/manage_submissions"
	end

	def resubmit
		@submission = Submission.find(params[:id])
		@problem = Problem.find(@submission.problem_id)
		@user = User.find(@submission.user_id)
		flash[:succ] = "Re-submitting, please wait then reload the page to update results"
		Thread.new do
			@submission.test_cases_passed, @submission.results = test_cases(@submission.language, @submission.id, @problem.test_cases, use_lrun=true, max_cpu_time=@problem.cpu_time, max_memory=@problem.memory)
			@submission.verdict = (@submission.test_cases_passed == @problem.number_of_test_cases)
			@submission.save

			score = ((@submission.test_cases_passed/@problem.number_of_test_cases)*@problem.score).floor

			# need to updated user problem_list
			# to reflect what happened
			lst = JSON.parse(@user.problem_list)
			lst[@problem.title]["attempted"] += 1
			past_score = lst[@problem.title]["score"]
			if past_score < score
				lst[@problem.title]["score"] = score
				@user.score -= past_score
				@user.score += score
				@problem.total_user_score -= past_score
				@problem.total_user_score += score
			end
			lst[@problem.title]["got_all_points"] = @submission.verdict
			@user.problem_list = lst.to_json
			@problem.save
			@user.save
		end
		redirect_to @submission
	end

	def submission_params
		params.require(:submission).permit(:code, :language)
	end

	def submission_params_with_problem_id
		params.require(:submission).permit(:problem_id, :code, :language)
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