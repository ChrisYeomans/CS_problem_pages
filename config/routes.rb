Rails.application.routes.draw do
  # index root and get
  get '/', to: "problems#index"
  get "/index", to: 'problems#index'
  root 'problems#index'

  # login and logout backdoors
  get "/back_in", to: "problems#back_in"
  post "/back_in", to: "problems#enter_back_in"
  get "/back_out", to: "problems#back_out"

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
    post "/problems/:id/pst", to: "problems#make_past"
    post "/problems/:id/curr", to: "problems#make_current"
    post "/problems/:id/hdn", to: "problems#make_hidden"
    post "/problems/:id/not_curr", to: "problems#make_not_current"

    get "/dashboard/manage_users", to: "dashboards#manage_users"

end