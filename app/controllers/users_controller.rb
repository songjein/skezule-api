class UsersController < ApplicationController
	require 'digest/sha1'

	def show
		render json: @current_user 
	end
	
	def create 
		user = User.new
		user.uid = params[:uid]
		user.name = params[:name]
		user.salt = BCrypt::Engine.generate_salt
		user.password = BCrypt::Engine.hash_secret(params[:password], user.salt)
		user.save
		render json: user
	end

end
