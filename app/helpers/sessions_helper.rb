module SessionsHelper
  def log_in(user)
    #creates a temporary cookie that is encrypeted using the seesion method.
    session[:user_id] = user.id
  end
  
  #generates cookies and a remember token for the logged in user
  def remember(user)
    #user model method generating a new remember token for the user in the DB 
    user.remember
    #secures cookies using signed method, and places the user_id in the cookie
    #otherwise, the user id would be stored as plain text, and therefore more susceptible to an attack
    cookies.permanent.signed[:user_id] = user.id
    #places the remember token in the cookie
    cookies.permanent[:remember_token] = user.remember_token
    
  end

  #instance variable used when the user accesses their profile information
  #the User DB is queried to find the user id in the session
  def current_user
    #if the session is still valid, the user id is found by that method
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    #if the session is not valid, the cookies is foudn and if authenticated, login occurs
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end      
  end

  #used in users controller to determine that the edit page requested is from the correct 
  #logged in user
  def current_user?(user)
    current_user == user
  end

  #used in the header layou to determine if the headeer should contain the proper links for the signed in user
  #true, unless current user is nil which is when the user is logged out
  def logged_in?
    !current_user.nil?
  end

  #called from the sessions controller to log out the current user and sets the current user to nil
  def log_out
    #calls sessions helper method forget to clear cookies
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    #calls user model method to clear remember digest in User DB
    user.forget
    #deletes user id cookies off of the users browser
    cookies.delete(:user_id)
    #deletes remember token cookies from user browser 
    cookies.delete(:remember_token)
  end

  #:forwarding_url is stored as session variable
  def redirect_back_or(default)
    #goes to the forwarding url, or the default nil.
    redirect_to(session[:forwarding_url] || default)
    #then deltes the forwarding url session variable
    session.delete(:forwarding_url)
  end

  #stores the location of the request in the session variable :forwarding_url
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
