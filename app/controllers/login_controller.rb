class LoginController < ApplicationController
  def create
    user = User.find_by_email(params[:email])  
    if user && user.authenticate(params[:password])  
      session[:user_id] = user.id
      redirect_to edit_surf_preference_path(user.surf_preferences.first) 
    else  
      flash[:notice] = "Invalid email or password"  
      render "index"  
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
