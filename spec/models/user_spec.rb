require 'spec_helper'

describe User do
  describe "validations" do
    it "should not validate an empty User" do
      User.new.should_not be_valid
    end
    
    it "should validate a complete User" do
      FactoryGirl.build(:user).should be_valid
    end
    
    it "should not validate a duplicate email" do
      FactoryGirl.create(:user, email: "foo@bar.com")
      FactoryGirl.build(:user, email: "foo@bar.com").should_not be_valid
    end
  end
end
