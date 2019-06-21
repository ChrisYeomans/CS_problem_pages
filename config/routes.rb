Rails.application.routes.draw do
  # index root and get
  get '/', to: "problems#index"
  get "/index", to: 'problems#index'
  root 'problems#index'

  # login and logout roots
  get "/login", to: "problems#login"
  post "/login", to: "problems#new_login"
  get "/logout", to: "problems#logout"

  # problem routes
  get "/past_problems", to: "problems#past_problems"
  get "/current_problem", to: "problems#current_problem"

  # dashboard routes
  get "/dashboard", to: "dashboards#index"

    # create problem
    resources :problems
    get "/dashboard/create_problem", to: "dashboards#create_problem"
    post "/dashboard/create_problem", to: "dashboards#add_problem_to_database"

    # manage problems
    get "/dashboard/manage_problems", to: "dashboards#manage_problems"
    post "/dashboard/manage_problems", to: "dashboards#delete_problem"

    get "/dashboard/set_current_problem", to: "dashboards#set_current_problem"
    get "/dashboard/manage_users", to: "dashboards#manage_users"

end