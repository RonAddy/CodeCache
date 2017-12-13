class SessionsController < ApplicationController
	
	# Will create a new instance of an User to pass through the new.html.erb view
	
	def new
		@user = User.new
		render :new
	end
	
	# Username and password from user object will be taken from parameters
	# A search for the user will be made using the username and password
	# if true, a message will be displayed and user page will be rendered
	# else, an error will display, a new user object will be made, and redirect to register page
	# username attempt will still be displayed on redirect
	def create 
		username = user_params[:username]
		password = user_params[:password]
		
		user = User.find_from_credentials(username, password)

	    if user
	       sign_in(user)
	       flash[:notice] = "Hey, #{username}! "
	       redirect_to user_path(user[:id])
	    else
	       flash[:error] = "User not found..."
	       @user = User.new(username: username)
	       render :new
	    end
	end
	
	# will sign user out and redirect to log in page
	def destroy
		sign_out
		flash[:notice] = 'You signed out!'
		redirect_to new_session_path
	end

  
	private
	
	def user_params
		  params.require(:user).permit(:username, :password)
	end
  
end
