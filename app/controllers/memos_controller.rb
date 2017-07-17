class MemosController < ApplicationController
	def index
		render json: @current_user
	end

	def create
		@current_user.memo = params[:memo]
		@current_user.save
		render json: @current_user
	end
end
