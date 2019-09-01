require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class UsersController < ApplicationController
  include UsersHelper

  # Function used to signup with GitHub OAuth
  def gh_callback

    access_token = get_gh_oauth_key
    # get user info
    auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
                              {:params => {:access_token => access_token}}))
    
    name = auth_result['login']
    email = auth_result['email']
    bio = auth_result['bio']
    gh_id = auth_result['id']

    if User.exists?(gh_oauth_key: gh_id)
      @user = User.find_by(gh_oauth_key: gh_id)
      log_in @user
      redirection_loc = user_path(@user) 
    else

      @user = User.new(
        {
          :name => name, :email => email, :bio => bio, 
          :password => "123456", :password_confirmation => "123456",
          :gh_oauth_key => gh_id, :is_admin => 0,
          :score => 0
        }
      )
      
      if @user.save
        redirection_loc = user_path(@user) + "/settings"
        log_in @user
        update_users
        flash[:succ] = "Account made, your password is currently 123456, please change it"
      else
        flash[:notice] = "Error"
        redirection_loc = "/"
      end
    end

    redirect_to redirection_loc
  end

  def get_gh_oauth_key
    @GH_CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
    @GH_CLIENT_SECRET = ENV['GH_BASIC_CLIENT_SECRET']
    # get temporary GitHub code
    session_code = request.env['rack.request.query_hash']['code']

    # post session code
    result = RestClient.post('https://github.com/login/oauth/access_token',
                            {:client_id => @GH_CLIENT_ID,
                            :client_secret => @GH_CLIENT_SECRET,
                            :code => session_code},
                            :accept => :json)

    # getting access token from result
    access_token = JSON.parse(result)['access_token']

    return access_token
  end

  # called by post of /user/new
  def new_user
    @user = User.new(user_params)
    @user.bio = params[:bio]
	  @user.is_admin = 0 # make users not admin by default
    @user.problem_list = p_list # p_list defined in UsersHelper
    @user.score = 0 # needs to be a default score to add to
  	if @user.save
      flash[:succ] = "Successfully created a new user, please login"
      log_in @user
      redirect_to @user
	  else
		  render 'new'
	  end
  end

  def new
    @GH_CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
    @GH_CLIENT_SECRET = ENV['GH_BASIC_CLIENT_SECRET']

    # giving new access to User object
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @markdown = Redcarpet::Markdown.new(CustomRender, md_arguments)
    @ordered_users = User.order(:score).reverse_order
    @ordered_users.each_with_index do |u, i|
      if u.id.to_i == params[:id].to_i
        @rank = i + 1
        break
      end
    end  
  end

  def login
    @GH_CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
    @user = User.new
  end

  def settings
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # Security Check
    if !((current_user.id == @user.id) || (current_user.is_admin == 1))
			return
		end

    if @user.update_attributes(user_params)
      flash[:succ] = "Saved data successfully"
    else
      flash[:notice] = "Error saving data"
    end

    redirect_to user_path(@user) + '/settings'
  end

  def make_admin

    # Security Check
		if !(current_user.is_admin == 1)
			return
    end
    
    @user = User.find(params[:id])
    @user.is_admin = 1
    @user.save
    redirect_to @user
  end

  def make_not_admin

    # Security Check
    if !(current_user.is_admin == 1)
			return
    end

    @user = User.find(params[:id])
    @user.is_admin = 0
    @user.save
    redirect_to @user
  end

  def reset_password

    # Security Check
    if !(current_user.is_admin == 1)
			return
    end

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

    # Security Check
    if !(current_user.is_admin == 1)
			return
    end

    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/dashboard/manage_users'
  end

  def update_users
    update_users_problems
  end

  def comments
    @user = User.find(params[:id])
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
