class LogsController < ApplicationController
	def index
		ret = []
		logs = @current_user.logs
		logs.each do |log|
			tmp_log = log.as_json
			tmp_log[:todos] = ""
			log.complete_todos.each_with_index do |ct, index|
				t = ct.todo
				tmp_log[:todos] += "<div>"
				if t.tag_list.length > 0
					tmp_log[:todos] += "[" + t.tag_list.to_s + "] " 
				end
				tmp_log[:todos] += t.goal
				if index < log.complete_todos.length - 1
					tmp_log[:todos] += "</div>"
				end
				tmp_log[:tag_list] = t.tag_list
			end
			ret << tmp_log
		end
		render json: ret 
	end
end
