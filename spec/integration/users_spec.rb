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
        integration_sign_in(User.new(:email=>"",:password=>""))
        response.should render_template('sessions/new')
        response.should have_tag("div.flash.error", /invalid/i)
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
<<<<<<< HEAD
        integration_sign_in(user)
                #controller.should be_signed_in
=======
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
>>>>>>> sessions_4_cookie
        controller.signed_in?.should be_true
        click_link "Sign out"
        controller.signed_in?.should be_false 
      end
<<<<<<< HEAD
  
      describe " login, logout and then login back as same user" do
        before(:each) do
            @user = Factory(:user)
            integration_sign_in(@user)
            @cookie=controller.current_user.remember_token
            click_link "Sign out"
            #sleep(2)
        end  

         it "should have a new cookie" do
           integration_sign_in(@user)
           puts @cookie
           puts controller.current_user.remember_token 
           controller.current_user.remember_token.should_not  eql(@cookie)

         end
      end
=======
     it "should have session " do
        user=Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        controller.session[:user].should be_nil
        click_button
        controller.session[:user].should_not be_nil
        click_link "Sign out"
        controller.session[:user].should be_nil
        puts "Still there is no test to emulate browser re-open to validate losing the session"
     end
      
>>>>>>> sessions_4_cookie
    end
  end
end
