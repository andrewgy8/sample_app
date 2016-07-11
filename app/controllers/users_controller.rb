class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    #generates a new user in the DB if the save is successful, then logs that user in and redirects the user to their profile show page
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcome to the sample app!"
    else
      render :new
    end
  end

  private
  #allows access from the User DB of the name email and password.
  #whitelisting these params
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
