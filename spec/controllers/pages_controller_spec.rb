require 'spec_helper'

describe PagesController do
  integrate_views
  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end

  before(:each) do
    @base_title="Ruby on Rails Tutorial Sample App | " 
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_tag("title",
                               @base_title+"Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get "contact"
      response.should have_tag("title",
                               @base_title+"Contact")
    end
  end
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_tag("title",
                               @base_title+"About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
      get 'help'
      response.should have_tag("title",
                               @base_title+"Help")
    end
  end 
  describe "get 'home'" do
    before(:each)do
      @user=Factory(:user)
      #Arrange for User.find(params[:id] to find right user
      User.stub!(:find,@user.id).and_return(@user)
      test_sign_in(@user)
    end
    it "should have the sidebar with correct micropost count " do
      mp1=Factory(:micropost, :user=>@user, :content=>"Foo bar")
      get :home
      response.should have_tag("span.microposts", "1 micropost")
      mp2=Factory(:micropost, :user=>@user, :content=> "Baz quuz")
      get :home
      response.should have_tag("span.microposts", "2 microposts")
    end
  end 

  describe "GET 'home'" do

    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_tag("title", "#{@base_title}Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        response.should have_tag("a[href=?]", following_user_path(@user), 
                                 /0 following/)
        response.should have_tag("a[href=?]", followers_user_path(@user), 
                                 /1 follower/)
      end
    end
  end


end
