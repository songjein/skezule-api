class LogsController < ApplicationController
	def index
		ret = []
		logs = @current_user.logs
		logs.each do |log|
			tmp_log = log.as_json
			tmp_log[:todos] = ""
			log.complete_todos.each_with_index do |ct, index|
				if index < log.complete_todos.length - 1
					tmp_log[:todos] += ct.todo.goal + ","
				else
					tmp_log[:todos] += ct.todo.goal 
				end
			end
			ret << tmp_log
		end
		render json: ret 
	end
end
