class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  def index
    @title = "All users"
    @users = User.paginate(:page=>params[:page])
  end
  def destroy
    user=User.find(params[:id]) 
    if user== current_user then 
      redirect_to root_path
      return 
    end 
    user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  def new
    if signed_in?  then 
      redirect_to root_path
      return
    end
  
    @title="Sign up"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title=CGI.escapeHTML(@user.name)
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def create
    if signed_in? then 
      redirect_to root_path
      return
    end
    @user=User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome "+@user.name 
      redirect_to @user
    else
      @title="Sign up"
      @user.password=""
      @user.password_confirmation=""
      render :action=>'new'
    end
  end
  def edit
    @title = "Edit user"
  end
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render :action=>:edit
    end
  end
  private
     def correct_user
      @user=User.find(params[:id]) 
      redirect_to(root_path) unless current_user?(@user)
    end
    def admin_user
      (redirect_to(signin_path); return) unless signed_in?
      redirect_to(root_path)   unless current_user.admin?
    end
end
