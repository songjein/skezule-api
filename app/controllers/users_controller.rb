class UsersController < ApplicationController
	skip_before_action :authenticate_request

	require 'digest/sha1'

	def show
	end
	
	def create 
		user = User.new
		user.user_id = params[:user_id]
		user.name = params[:name]
		user.password = params[:password]
		user.password_confirmation = params[:password_confirmation]

		if user.save
			render json: user
		else
			render json: { "error": user.errors.full_messages }
		end
	end

end
