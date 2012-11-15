require 'spec_helper'

describe UsersController do
  describe "#new" do
    it "should have good status" do
      get :new
      response.status.should == 200
    end
  end
  
  describe "#create" do
    it "should update fields correctly" do
      post :create, :user => FactoryGirl.attributes_for(:user)
      response.should redirect_to(surf_preferences_path)
    end
    
    it "should fail validations" do
      post :create, :user => FactoryGirl.attributes_for(:user, email: nil)
      response.status.should == 200
    end
  end
end
