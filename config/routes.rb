Rails.application.routes.draw do
  # It's funny to hear ruby talking about.... "routes"

  # index root and get
  get '/', to: "problems#index"
  get "/index", to: 'problems#index'
  root 'problems#index'

  # problem routes
  resources :problems
  get "/past_problems", to: "problems#past_problems"
  get "/current_problem", to: "problems#current_problem"

  # submission routes
  resources :submissions
  post "/submissions/:id/resubmit", to: "submissions#resubmit"

  # user routes
  resources :users
  get "/user/new", to: "users#new"
  post "/user/new", to: "users#new_user"
  get "/login", to: "users#login"

    # user settings
    get "/user/:id/settings", to: "users#settings"
    post "/user/:id/settings", to: "users#update"
    get "/users/:id/change_pw", to: "users#change_pw"
    post "/users/:id/change_pw", to: "users#update_pw"

  # session routes
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"

  # dashboard routes
  get "/dashboard", to: "dashboards#index"

    # create problem
    get "/dashboard/create_problem", to: "dashboards#create_problem"

    # manage problems
    get "/dashboard/manage_problems", to: "dashboards#manage_problems"
    post "/problems/:id/pst", to: "problems#make_past"
    post "/problems/:id/curr", to: "problems#make_current"
    post "/problems/:id/hdn", to: "problems#make_hidden"
    post "/problems/:id/not_curr", to: "problems#make_not_current"

    # manage users
    get "/dashboard/manage_users", to: "dashboards#manage_users"
    post "/users/:id/make_admin", to: "users#make_admin"
    post "/users/:id/make_not_admin", to: "users#make_not_admin"
    post "/users/:id/reset_password", to: "users#reset_password"
    post "/users/:id/delete_user", to: "users#delete_user"
    post "/update_users", to: "users#update_users"

end