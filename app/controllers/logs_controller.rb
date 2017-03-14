class LogsController < ApplicationController
	def index
		logs = Log.all
		render json: logs
	end
end
