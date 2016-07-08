class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = 'Incorrect Email/Password. Please try again.'
      render 'new'
      #create error message
    end
  end

  def destroy
    
  end
end