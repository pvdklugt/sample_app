class PagesController < ApplicationController
    
  def home
    @title = "Home"
    if signed_in?      
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      # _validators works in rails console, but not here (returns nil)
      @micropost_maxlen = @micropost._validators[:content][1].options[:maximum].to_s
      @micropost_maxlen = '140'
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
  
end
