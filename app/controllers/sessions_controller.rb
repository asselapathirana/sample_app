class SessionsController < ApplicationController
  ssl_required :new, :create
  def new
    @title="Sign in"   
  end
  def create
     user = User.authenticate(params[:session][:email],
                              params[:session][:password])
    if user.nil?
      #failed
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render :action=>:new
    else
      #logged in
      sign_in user
      redirect_to user

      
    end 
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
