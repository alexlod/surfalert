class SurfPreferencesController < ApplicationController
  before_filter :requires_login
  
  def index
    @surf_preferences = current_user.surf_preferences
  end
  
  def new
    @surf_preference = SurfPreference.new
  end
  
  def create
    @surf_preference = SurfPreference.new(params[:surf_preference])
    @surf_preference.user = current_user
    if @surf_preference.save
      flash[:notice] = "Your preferences have been created."
      redirect_to surf_preferences_path
    else
      render "new"
    end
  end
  
  def edit
    @surf_preference = SurfPreference.find(params[:id])
  end
  
  def update
    @surf_preference = SurfPreference.find(params[:id])
    if @surf_preference.update_attributes(params[:surf_preference])
      flash[:notice] = "Your preferences have been saved."
      redirect_to surf_preferences_path
    else
      render "edit"
    end
  end
  
  def destroy
    @surf_preference = SurfPreference.find(params[:id])
    @surf_preference.destroy
    flash[:notice] = "Your preference has been deleted."
    redirect_to surf_preferences_path
  end
end
