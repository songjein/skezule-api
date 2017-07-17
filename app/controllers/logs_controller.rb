class LogsController < ApplicationController
	def index
		logs = @current_user.logs
		render json: logs
	end
end
