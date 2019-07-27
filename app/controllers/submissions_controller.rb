require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class SubmissionsController < ApplicationController
	def show
		@submission = Submission.find(params[:id])
		@problem = Problem.find(@submission.problem_id)
		@markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
	end
end
