class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # define sign in method in application controller so sign can be used anywhere in app
  # token variable will be given random string
  # Session object property "session_token" will be assigned the token 
  # user session token will then be updated
  def sign_in(user)
	  token = SecureRandom.urlsafe_base64 #outputs random 22-char string
	  session[:session_token] = token
	  user.update_attribute(:session_token, token)
  end
end
