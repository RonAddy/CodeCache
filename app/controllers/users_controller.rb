class UsersController < ApplicationController
	# will ensure user is signed out on the register form and when handling post request to create user
  before_action :ensure_signed_out, only: [:new, :create]
  before_action :ensure_signed_in, only: [:show, :index]

  # will render register page to create a new user
  def new
    @user = User.new
  end

 # Will make post request if made user passes validations, and sign user in 
  def create
    @user = User.new(create_params)

    if @user.save
      sign_in(@user)
      flash[:notice] = 'You are signed in!'
      redirect_to user_path(@user[:id])
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
	  #make this user profile page!
    @user = User.find(params[:id])
  end

  private

  def create_params
    params.require(:user).permit(:username, :password)
  end
end
