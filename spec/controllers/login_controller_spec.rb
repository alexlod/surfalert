require 'spec_helper'

describe LoginController do
  describe "#index" do
    it "should return with good status" do
      get :index
      response.status.should == 200
    end
  end
  
  describe "#create" do
    it "should log the user in" do
      pass = "foo"
      user = FactoryGirl.create(:user, password: pass)
      post :create, :email => user.email, :password => pass
      session[:user_id].should == user.id
    end
    
    it "should not log the user in" do
      pass = "foo"
      user = FactoryGirl.create(:user, password: pass)
      post :create, :email => user.email, :password => "bar"
      session[:user_id].should == nil
    end
  end
  
  describe "#destroy" do
    it "should log the user out" do
      session[:user_id] = FactoryGirl.create(:user).id
      get :destroy
      session[:user_id].should == nil
    end
  end
end
