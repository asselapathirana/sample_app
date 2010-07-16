require 'spec_helper'
include SessionsHelper

describe "Users" do 
  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          click_button
          response.should render_template('users/new')
          response.should have_tag("div#errorExplanation")
        end.should_not change(User, :count)
      end
   end
   describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "sign in/out" do
      
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should render_template('sessions/new')
        response.should have_tag("div.flash.error", /invalid/i)
      end
    end

    describe "success" do
      before(:each) do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
      end 
      it "should sign a user in and out" do
        controller.signed_in?.should be_true
        click_link "Sign out"
        controller.signed_in?.should be_false 
      end
     it "should have session " do
        controller.session[:user].should_not be_nil
        click_link "Sign out"
        controller.session[:user].should be_nil
        puts "Still there is no test to emulate browser re-open to validate losing the session"
     end
     describe " and try to access  " do
       it " 'new' should redirect to root url" do
         visit signup_path
         response.should render_template('pages/home')
       end
       it " 'create' should redirect to root url" do
         visit "users", :post, :users =>{:email=>"fox@box.com", :password=>"heeheehee", :password_confirmation=>"heeheehee", :name=>"boo bax"}
         response.should render_template('pages/home')
       end

     end
    end
  end
end
