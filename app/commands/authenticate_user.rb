# this command has to take the user's id and password
# and return 'the user' if the credentials match
class AuthenticateUser
	prepend SimpleCommand

	# this is where params are taken when the command is called
	def initialize(user_id, password)
		@user_id = user_id 
		@password = password
	end
	
	# this is where the result gets retured
	def call
		JsonWebToken.encode(user_id: user.id) if user	
	end

	private

	attr_accessor :user_id, :password

	def user
		user = User.find_by_user_id(user_id)
		return user if user && user.authenticate(password)

		errors.add :user_authenticate, 'invalid credentials'
		nil
	end
end
