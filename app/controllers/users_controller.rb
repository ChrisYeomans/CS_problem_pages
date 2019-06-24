class UsersController < ApplicationController
  @user = User.new
  def new_user
    @user = User.new(user_params)
	  @user.is_admin = 0 # make users not admin by default
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
    if @user.save
      flash[:notice] = "Password changed successfully"
      redirect_to @user
    else
      render 'change_pw'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "Saved data successfully"
      redirect_to @user
    else
      render "settings"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to '/'
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
    @user.password = "1234"
    @user.password_confirmation = "1234"
    if @user.save
      flash[:notice] = "Password reset successfully"
      redirect_to @user
    else
      flash[:notice] = "Password not reset"
      redirect_to "/dashboard/manage_users"
    end
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/dashboard/manage_users'
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin, :password_confirmation)
  end
end
