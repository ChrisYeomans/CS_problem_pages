require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'json'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class SubmissionsController < ApplicationController
	include SessionsHelper
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
		@submission = Submission.new(submission_params)
		@submission.user_id = current_user.id
		@user = User.find(@submission.user_id)
		@problem = Problem.find(@submission.problem_id)

		flash[:succ] = "Submitted please wait then reload to update results"
		if @submission.save
			#Thread.new do
				@submission.test_cases_passed, @submission.results = test_cases(@submission.extension, @submission.language, @submission.id, @problem.test_cases, use_lrun=true, max_cpu_time=@problem.cpu_time, max_memory=@problem.memory)
				@submission.verdict = (@submission.test_cases_passed == @problem.number_of_test_cases)
				@submission.save

				# update user total score
				score = ((@submission.test_cases_passed/@problem.number_of_test_cases)*@problem.score).floor
				@user.score += score
				
				# need to updated user problem_list
				# to reflect what happened
				lst = JSON.parse(@user.problem_list)
				lst[@problem.title]["attempted"] += 1
				lst[@problem.title]["score"] = score
				lst[@problem.title]["got_all_points"] = @submission.verdict
				@user.problem_list = lst.to_json
				@user.save
			#end

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
		score = ((@submission.test_cases_passed/@problem.number_of_test_cases)*@problem.score).floor

		flash[:succ] = "Re-submitting, please wait then reload the page to update results"
		#Thread.new do
			@submission.test_cases_passed, @submission.results = test_cases(@submission.extension, @submission.language, @submission.id, @problem.test_cases, use_lrun=true, max_cpu_time=@problem.cpu_time, max_memory=@problem.memory)
			@submission.verdict = (@submission.test_cases_passed == @problem.number_of_test_cases)
			@submission.save


			# need to updated user problem_list
			# to reflect what happened
			lst = JSON.parse(@user.problem_list)
			lst[@problem.title]["attempted"] += 1
			past_score = lst[@problem.title]["score"]
			if past_score < score
				lst[@problem.title]["score"] = score
				@user.score -= past_score
				@user.score += score
			end
			lst[@problem.title]["got_all_points"] = @submission.verdict
			@user.problem_list = lst.to_json
			@user.save
		#end
		redirect_to @submission
	end

	def submission_params
		params.require(:submission).permit(:problem_id, :code, :language, :extension)
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