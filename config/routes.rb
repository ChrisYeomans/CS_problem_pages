def check
	if not session[:user_id] == 1234
		false
	else
		true
	end
end

Rails.application.routes.draw do
  # index root and get
  get '/', to: "problems#index"
  get 'problems/index'
  root 'problems#index'

  # login and logoit roots
  get "/login", to: "problems#login"
  post "/login", to: "problems#new_login"
  get "/logout", to: "problems#logout"


  get "/dashboard", to: "dashboards#index"
  get "/dashboard/lol", to: "dashboards#lol"

end