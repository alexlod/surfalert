Surfalert::Application.routes.draw do
  resources :surf_preferences, :only => [:show, :edit, :update]
  resources :users
  resources :login, :only => [:index, :create]
  root :to => redirect("/login")
end
