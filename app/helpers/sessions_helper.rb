module SessionsHelper

  def sign_in(user)
    # cookies replaced with session (Exercise 9.6.2)
    # Also see http://www.nimweb.it/web-development/ruby-on-rails-web-development/ruby-on-rails-tutorial-exercise-9-6-2-rails-session/
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    session[:remember_token] = [user.id, user.salt]  
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    # cookies.delete(:remember_token)   # cookies replaced with session (Exercise 9.6.2)
    session[:remember_token] = nil    
    #self niet verwijderen!
    self.current_user = nil  
  end

  def current_user?(user)
    user == current_user
  end
  
  def authenticate
    deny_access unless signed_in?
  end
    
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      # cookies replaced with session (Exercise 9.6.2)
      # cookies.signed[:remember_token] || [nil, nil] 
      session[:remember_token] || [nil, nil]  
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end
