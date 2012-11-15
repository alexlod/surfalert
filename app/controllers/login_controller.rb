class LoginController < ApplicationController
  before_filter :requires_login, :only => [:destroy]
  
  def create
    user = User.find_by_email(params[:email])  
    if user && user.authenticate(params[:password])  
      session[:user_id] = user.id
      redirect_to surf_preferences_path
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
