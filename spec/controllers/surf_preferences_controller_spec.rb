require 'spec_helper'

describe SurfPreferencesController do
  before(:each) do
    session[:user_id] = FactoryGirl.create(:user).id
  end
  
  describe "#new" do
    it "should have good status" do
      get :new
      response.status.should == 200
    end
  end
  
  describe "#create" do
    it "should save correctly" do
      post :create, :surf_preference => FactoryGirl.attributes_for(:surf_preference)
      pref = SurfPreference.all.first
      response.should redirect_to(surf_preferences_path)
      pref.user_id.should == session[:user_id]
    end
    
    it "should fail validations" do
      post :create, :surf_preference => FactoryGirl.attributes_for(:surf_preference, min_shape: nil)
      response.status.should == 200
      SurfPreference.all.count.should == 0
    end
  end
  
  describe "#edit" do
    it "should have good status" do
      pref = FactoryGirl.create(:surf_preference)
      get :edit, :id => pref.id
      response.status.should == 200
    end
  end
  
  describe "#update" do
    it "should update fields correctly" do
      pref = FactoryGirl.create(:surf_preference)
      new_min_size = pref.min_size + 1
      put :update, :id => pref.id, :surf_preference => {
        :max_size => pref.max_size,
        :min_size => new_min_size,
        :min_shape => pref.min_shape,
        :spot_id => pref.spot_id
      }
      response.should redirect_to(surf_preferences_path)
      pref = SurfPreference.find(pref.id) # sync from the db.
      pref.min_size.should == new_min_size
    end
    
    it "should fail validations" do
      pref = FactoryGirl.create(:surf_preference)
      orig_min_size = pref.min_size
      put :update, :id => pref.id, :surf_preference => {
        :max_size => pref.max_size,
        :min_size => nil,
        :min_shape => pref.min_shape,
        :spot_id => pref.spot_id
      }
      response.status.should == 200
      pref = SurfPreference.find(pref.id) # sync from the db.
      pref.min_size.should == orig_min_size
    end
  end
end
