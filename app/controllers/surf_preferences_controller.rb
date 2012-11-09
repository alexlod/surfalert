class SurfPreferencesController < ApplicationController
  before_filter :requires_login
  
  def edit
    @surf_preference = SurfPreference.find(params[:id])
  end
  
  def update
    @surf_preference = SurfPreference.find(params[:id])
    if @surf_preference.update_attributes(params[:surf_preference])
      flash[:notice] = "Your preferences have been saved."
      redirect_to edit_surf_preference_path(@surf_preference)
    else
      render "edit"
    end
  end
end
