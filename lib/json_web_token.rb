# lib/json_web_token.rb
class JsonWebToken
	class << self
		# for authenticating the user and generate a token for him/her 
		# takes 3 params ; user id, exp time, unique base key using encode
		def encode(payload, exp=24.hours.from_now)
			payload[:exp] = exp.to_i
			JWT.encode(payload, Rails.application.secrets.secret_key_base)
		end
		
		# to check if the user's token appended in each request is correct by using decode
		def decode(token)
			body = JWT.decode(token, Rails.application.secrets.secret_key_base)
			#HashWithIndifferentAcesss.new body
		end	
	end
end
