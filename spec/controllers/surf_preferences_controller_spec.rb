require 'spec_helper'

describe SurfPreferencesController do
  before(:each) do
    request.env["rack.url_scheme"] = "https"
    request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64([ENV["AUTH_USERNAME"], ENV["AUTH_PASSWORD"]].join(":"))
  end
  
  describe "#edit" do
    it "should fail when bad authentication credentials are given" do
      request.env["HTTP_AUTHORIZATION"] = nil
      pref = FactoryGirl.create(:surf_preference)
      get :edit, :id => pref.id
      response.status.should == 401
    end
    
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
        :spot_id => pref.spot_id,
        :phone_no => pref.phone_no
      }
      response.should redirect_to(edit_surf_preference_path(pref))
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
        :spot_id => pref.spot_id,
        :phone_no => pref.phone_no
      }
      response.status.should == 200
      pref = SurfPreference.find(pref.id) # sync from the db.
      pref.min_size.should == orig_min_size
    end
  end
end
