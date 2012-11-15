class UsersController < ApplicationController

  def new
    @user = User.new(params[:user])
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully signed up!"
      redirect_to surf_preferences_path
    else
      render "new"
    end
  end
end
