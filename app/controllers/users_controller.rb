class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
    
  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
#     raise params[:user].inspect
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
end
