class User < ApplicationRecord
	
	# validates presence of a username when user is created
	validates_presence_of :username
	
	# validates that username is unique and is long enough
	validates :username, length: (6..25), uniqueness: true
	
	#this will help to validate passwords before they are hashed and stored
	# by saving the user input to the instance variable, the password will have to go through validation first
	# allow nil for user inout that dows not need password input
	validates :password,  length: (8..20), allow_nil: true
	
	
	
	attr_reader :password
	
	# 	This method will allow me to check the password attempt
	# A new password object will be created(but not saved) comparing the current password_digest to the pasword attempt's digest
	def is_password?(password_attempt)
		BCrypt::Password.new(password_digest).is_password?(password_attempt)
	end
	
	# The equal sign next to password will allow us to set a password value directly instead of having to pass it as a parameter
	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
	
	
	# Self in method defineition refres to the class 
	# self within the method refers to every instance of a user
	# will check if the username is tue first
	# then wil check if password attempt is equal to password_digets for user
	# will return nil(falsy) if any of those fail
	def self.find_from_credentials(username, password)
		user = find_by(username: username)
		return nil unless user
		user if user.is_password?(password)
	end
end
