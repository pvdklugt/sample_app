require 'spec_helper'

describe PagesController do

  include RSpec::Rails::ControllerExampleGroup
  
  render_views
  
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
  
    describe "when not signed in" do
      it "should be successful" do
        get 'home'
        response.should be_success
      end
      
      it "should have the rigth title" do
        get 'home'
        response.should have_selector("title",
           :content => "#{@base_title} | Home")
      end
      
      it "should have a non-blank body" do
        get 'home'
        response.body.should_not =~ /<body>\s*<\/body>/
      end    
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should show the right micropost count" do
        # Exercise 11.5.2 -> test for 0 to 3 microposts
        3.times do
          get :home
          response.should have_selector('span.stat', :id => 'microposts', :content => @user.microposts.count.to_s)      
          # :content => @user.microposts.count.to_s << " micropost" << (@user.microposts.count != 1 ? "s" : ""))      
          Factory(:micropost, :user => @user, :content => Factory.next(:content))               
        end
        get :home
        response.should have_selector('span.stat', :id => 'microposts', :content => @user.microposts.count.to_s)
      end
      
      it "should have the right follower/following counts" do
        get :home
        response.should have_selector('a', :href => following_user_path(@user),
                                           :content => "0")
        response.should have_selector('a', :href => followers_user_path(@user),
                                           :content => "1")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the rigth title" do
      get 'contact'
      response.should have_selector("title",
         :content => "#{@base_title} | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the rigth title" do
      get 'about'
      response.should have_selector("title",
         :content => "#{@base_title} | About")
    end   
  end
    
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the rigth title" do
      get 'help'
      response.should have_selector("title",
         :content => "#{@base_title} | Help")
    end       
  end
  
end
