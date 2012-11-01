Surfalert::Application.routes.draw do
  resources :surf_preferences, :only => [:show, :edit, :update]
  resources :users
  root :to => redirect("/users/new")
end
