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
  
  # sign out method will return nill unless current_user is true (logged in)
  # if ture, the current_user token will be updated to nil (session over)
  # session token will be deleted on session object
   def sign_out
	    return unless current_user
	    current_user.update!(session_token: nil)
	    session.delete(:session_token)
  end
  
  # current_user method made to prevent having to make database query evrytime we need the current user
  # that query is made once with the find_current_user method
  # @current_user will equal the user from first query or will be assigned current user if nil
  def current_user
    @current_user ||= find_current_user
  end

  def find_current_user
    session_token = session[:session_token]
    session_token && User.find_by(session_token: session_token)
  end

  # this method will make sure a user is logged in before allowing acces s to user specific pages
  # will return nill if user is true (logged in)
  # will display error message and redirect to root if the user is not logged in
  # add "before_action :ensure_signed_in" in any controller that needs user to be logged in
  
  def ensure_signed_in
    return if current_user
    flash[:error] = 'you must be signed in to see this'
    redirect_to :root
  end

  # for pages that need to be accessed by those who are not users (register page)
  
  def ensure_signed_out
    return unless current_user
    flash[:error] = 'you are already signed in'
    redirect_to users_path
  end
end
