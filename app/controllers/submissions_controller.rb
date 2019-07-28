require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

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

		if @submission.save
			@submission.test_cases_passed, @submission.results = test_cases(@submission.extension, @submission.language, @submission.id, Problem.find(@submission.problem_id).test_cases, use_lrun=false)
			@submission.verdict = (@submission.test_cases_passed == Problem.find(@submission.problem_id).number_of_test_cases)
			@submission.save
			flash[:succ] = "Successfull Submission"
			redirect_to @submission
		else
			flash[:notice] = "Error in submitting"
			redirect_to @submission
		end
	end

	def edit
		@submission = Submission.find(params[:id])
	end

	def destroy
		@submission = Submission.find(params[:id])
		@submission.destroy
		flash[:succ] = "Submission Destroyed"
		redirect_to submissions_path
	end

	def resubmit
		@submission = Submission.find(params[:id])
		@submission.test_cases_passed, @submission.results = test_cases(@submission.extension, @submission.language, @submission.id, Problem.find(@submission.problem_id).test_cases, use_lrun=false)
		@submission.verdict = (@submission.test_cases_passed == Problem.find(@submission.problem_id).number_of_test_cases)
		if @submission.save
			flash[:succ] = "Re-Submitted"
		else
			flash[:notice] = "Error not Re-Submitted"
		end
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