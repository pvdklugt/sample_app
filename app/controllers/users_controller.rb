class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  before_filter :not4users,    :only => [:new, :create]

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    # raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
    else
      # reset password fields after failed submission (see exercise 8.6.2)
      @user.password = ""
      @user.password_confirmation = ""   
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    # raise request.inspect
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @user.destroy  #@user is created by the admin_user method
    # redirect_to users_path, :flash => { :success => "User destroyed." }
    redirect_to session[:return_to], :flash => { :success => "User destroyed." }
  end
 
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end

    def not4users
      message = "Action prohibited for signed-in users."
      redirect_to root_path, :flash => { :notice => message } if signed_in?    
    end  
end
