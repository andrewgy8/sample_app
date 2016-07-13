class UsersController < ApplicationController
  
  #no user should be able to edit or update without having logged in
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    #generates a new user in the DB if the save is successful, then logs that 
    #user in and redirects the user to their profile show page
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcome to the sample app!"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    #allows an update of the users values if the update attributes is successful
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Successfully Updated"
      redirect_to @user

    else
      render 'edit'
    end
  end

  def index 
    @users = User.paginate(page: params[:page])   
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully deleted"
    redirect_to users_url
  end

  #*********************************private methods**************************************


  private
    #allows access from the User DB of the name email and password.
    #whitelisting these params
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #confirms that a user is logged in called above for the before_action
    def logged_in_user
      unless logged_in?
        #save the denied access page to a session variable suing method defined
        #in the sessions helper
        store_location
        flash[:danger] = "You must be logged in to do that."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      #uses the current_user? method found in sessions helper which is required by the 
      #application controller therefore inherited by the users controller
      #
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
      
    end
end
