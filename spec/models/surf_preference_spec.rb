require 'spec_helper'

describe SurfPreference do
  describe "validations" do
    it "should not validate an empty SurfPreference" do
      SurfPreference.new.should_not be_valid
    end
    
    it "should validate a complete SurfPreference" do
      FactoryGirl.build(:surf_preference).should be_valid
    end
  end
  
  describe "#shape_good_enough?" do
    it "should be true for same values" do
      pref = FactoryGirl.create(:surf_preference, min_shape: "p")
      pref.shape_good_enough?("p").should == true
    end
    
    it "should be true when the minimum is met" do
      pref = FactoryGirl.create(:surf_preference, min_shape: "p")
      pref.shape_good_enough?("pf").should == true
      pref.shape_good_enough?("f").should == true
      pref.shape_good_enough?("fg").should == true
      pref.shape_good_enough?("g").should == true
    end
    
    it "should be false when the minimum is not met" do
      pref = FactoryGirl.create(:surf_preference, min_shape: "g")
      pref.shape_good_enough?("p").should == false
      pref.shape_good_enough?("pf").should == false
      pref.shape_good_enough?("f").should == false
      pref.shape_good_enough?("fg").should == false
    end
    
    it "should work as expected for a middle value" do
      pref = FactoryGirl.create(:surf_preference, min_shape: "f")
      pref.shape_good_enough?("p").should == false
      pref.shape_good_enough?("pf").should == false
      pref.shape_good_enough?("f").should == true
      pref.shape_good_enough?("fg").should == true
      pref.shape_good_enough?("g").should == true
    end
  end
end
