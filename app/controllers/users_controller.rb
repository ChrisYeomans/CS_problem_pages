require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class UsersController < ApplicationController
  include UsersHelper

  # called by post of /user/new
  def new_user
    @user = User.new(user_params)
	  @user.is_admin = 0 # make users not admin by default
    @user.problem_list = p_list
  	if @user.save
      flash[:succ] = "Successfully created a new user, please login"
  		redirect_to "/login"
	  else
		  render 'new'
	  end
  end

  def new
    # giving new access to User object
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
  end

  def login
    @user = User.new
  end

  def settings
    @user = User.find(params[:id]) 
  end

  def change_pw
    @user = User.find(params[:id])
  end

  # post of change_pw
  def update_pw
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:succ] = "Password changed successfully"
      redirect_to @user
    else
      render 'change_pw'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:succ] = "Saved data successfully"
      redirect_to @user
    else
      render "settings"
    end
  end

  def make_admin
    @user = User.find(params[:id])
    @user.is_admin = 1
    @user.save
    redirect_to @user
  end

  def make_not_admin
    @user = User.find(params[:id])
    @user.is_admin = 0
    @user.save
    redirect_to @user
  end

  def reset_password
    @user = User.find(params[:id])
    @user.password = "123456"
    @user.password_confirmation = "123456"
    if @user.save
      flash[:succ] = "Password reset successfully"
      redirect_to @user
    else
      flash[:notice] = "Password not reset"
      redirect_to @user
    end
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/dashboard/manage_users'
  end

  def update_users
    update_users_problems
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin, :password_confirmation, :bio)
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
