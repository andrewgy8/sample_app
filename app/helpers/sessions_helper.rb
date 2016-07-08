module SessionsHelper
  def log_in(user)
    #creates a temporary cookie that is encrypeted using the seesion method.
    session[:user_id] = user_id
  end
end
