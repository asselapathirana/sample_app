require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @valid_attributes = {
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@valid_attributes)
  end
  describe "User associations" do
    before(:each) do
      @micropost=@user.microposts.create(@valid_attributes)
    end

    it "should have a user attribute" do 
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end
  
  describe "validations. Micropost" do
    it "sould require a user id" do
      Micropost.new(@valid_attributes).should_not be_valid
    end
    it "should require non-blank content" do 
      @user.microposts.build(:content=>"  \t").should_not be_valid
    end
    it "should reject long content" do
      @user.microposts.build(:content=>"a"*141).should_not be_valid
    end
  end
end
