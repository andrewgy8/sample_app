class SessionsController < ApplicationController
  def new
  end

  def create
    #takes the email and password from the new.html.erb form, passing the email from the form to query the user DB by email
    user = User.find_by(email: params[:session][:email].downcase)
    #takes the input password and passes it through rails method authenticate to compare password digest to the input password
    if user && user.authenticate(params[:session][:password])
      #logs in the user using the sessions helper method creating a session for that user using their :user_id
      log_in(user)

      #if the value of the checkbox icon is 1, the user is remembered which is the default setting
      #else the user has unchecked the box, and the user is not remembered with cookies when redirected to the user page
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)

      #redirects to the show.html.erb of the user, gravatar and profile info
      redirect_back_or user
    else
      #
      flash.now[:danger] = 'Incorrect Email/Password. Please try again.'
      render 'new'
      #create error message
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

#sessions is temporary and cookies is more permanent. The user must log in everytime they open and close
#the browser if cookies is not placed.