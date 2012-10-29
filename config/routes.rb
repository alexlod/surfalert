Surfalert::Application.routes.draw do
  resources :surf_preferences, :only => [:show, :edit, :update]
  root :to => redirect("/surf_preferences/1/edit")
end
