require 'digest/sha2'

class UsersController < ApplicationController
  def new_user
  	@user = User.new(user_params)
	  @user.is_admin = 0 # make users not admin by default
    # hash password because duh
  	@user.password = Digest::SHA256.new << @user.password
  	if @user.save
  		redirect_to @user
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

  def update_pw
    @user = User.find(params[:id])
    if params[:user][:password] == params[:user][:password_confirmation]
      @user.password = Digest::SHA256.new << params[:user][:password]
      @user.save
      redirect_to @user
    else
      flash[:notice] = 'Passwords do not match'
      render 'change_pw'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin)
  end
end
