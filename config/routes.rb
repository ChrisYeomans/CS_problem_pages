Rails.application.routes.draw do
  get 'problems/index'
  root 'problems#index'

  get "/login", to: "problems#login"
  post "/login", to: "problems#new_login"
  get "/logout", to: "problems#logout"
  post "/logout", to: "problems#destroy_login"

end
