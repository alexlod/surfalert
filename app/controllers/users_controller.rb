class UsersController < ApplicationController

  def new
    @user = User.new(params[:user])
    @user.surf_preferences.new(:max_size => 4,
                               :min_size => 2,
                               :min_shape => "fg",
                               :spot_id => 114)
  end
 
  def create
    @user = User.new(params[:user])
    @user.surf_preferences.new(:max_size => 4,
                               :min_size => 2,
                               :min_shape => "fg",
                               :spot_id => 114)
    if @user.save
      flash[:notice] = "Successfully signed up!"
      redirect_to edit_surf_preference_path(@user.surf_preferences.first)
    else
      render "new"
    end
  end
end
