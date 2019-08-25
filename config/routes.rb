Rails.application.routes.draw do
  # It's funny to hear ruby talking about... "routes"

  # ajax update routes
  patch '/submissions/:id/update_results', to: 'submissions#results'
  patch '/update_user_table', to: 'dashboards#update_user_table'
  patch '/update_problem_table', to: 'dashboards#update_problem_table'
  patch '/update_submission_table', to: 'dashboards#update_submission_table'
  patch '/update_past_problems', to: 'problems#update_past_problems'
  patch '/update_solution_table', to: 'dashboards#update_solution_table'

  # index root and get
  get '/', to: "problems#index"
  get "/index", to: 'problems#index'
  root 'problems#index'

  # problem routes
  resources :problems
  get "/past_problems", to: "problems#past_problems"
  get "/current_problem", to: "problems#current_problem"

  # problem solution routes
  resources :problem_solutions
  get "/current_solution", to: "problem_solutions#current_solution"

  # comment routes
  resources :comments
  get "/users/:id/comments", to: "users#comments"

  # submission routes
  resources :submissions
  post "/submissions/:id/resubmit", to: "submissions#resubmit"

  # user routes
  resources :users
  get "/user/new", to: "users#new"
  post "/user/new", to: "users#new_user"
  get "/login", to: "users#login"
  get "/gh_callback", to: "users#gh_callback"
  get "/user/new_oath", to: "users#new_oath"

    # user settings
    get "/users/:id/settings", to: "users#settings"
    post "/users/:id/settings", to: "users#update"
    get "/users/:id/change_pw", to: "users#change_pw"
    post "/users/:id/change_pw", to: "users#update_pw"

  # session routes
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"

  # dashboard routes
  get "/dashboard", to: "dashboards#index"
  get "/tcs", to: "dashboards#tcs"

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

    # manage submissions
    get "/dashboard/manage_submissions", to: "dashboards#manage_submissions"

    # manage comments
    get "/dashboard/manage_comments", to: "dashboards#manage_comments"
  
    # manage Solution Routes
    get "/problem_solution", to: "dashboards#manage_solutions"
    get "/dashboard/manage_solutions", to: "dashboards#manage_solutions"
    get "/dashboard/manage_problem_solutions", to: "dashboards#manage_solutions"
    post "/problem_solutions/:id/curr", to: "problem_solutions#make_current"
    post "/problem_solutions/:id/not_curr", to: "problem_solutions#make_not_current"

end