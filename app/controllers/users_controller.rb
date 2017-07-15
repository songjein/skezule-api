class UsersController < ApplicationController
	require 'digest/sha1'

	def show
		#user = User.find_by(id: params[:id])
		#render json: user
		render json: {message: "login", user: session[:user_id]}
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

	def login
		uid = params[:uid]
		user = User.find_by(uid: uid)
		if !user
			render json: {message: 'no id'}
			return
		end
		password = BCrypt::Engine.hash_secret(params[:password], user.salt)

		if user 
			if user.password == password	
				# 로그인
				session[:user_id] = user.id
				render json: {message: session[:user_id]}
			else
				# 비번 틀림
				render json: {message: 'pw'}
			end
		else 
			# 아디 존재 x
			render json: {message: 'id'}
		end	
	end

	def logout 
		if session[:user_id] 
			session.delete(:user_id)
		end
	end
end
