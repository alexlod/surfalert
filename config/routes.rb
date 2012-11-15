Surfalert::Application.routes.draw do
  resources :surf_preferences
  resources :users
  
  get "login" => 'login#index'
  post "login" => 'login#create'
  get "logout" => 'login#destroy'
  
  root :to => redirect("/login")
end
