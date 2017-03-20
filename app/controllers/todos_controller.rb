class TodosController < ApplicationController
	def index
		ret = []
		todos = Todo.all
		todos.each do |todo|
			tmp_todo = todo.as_json
			tmp_todo[:tag_list] = todo.tag_list
			ret << tmp_todo
		end
		render json: ret 
	end

	def notCompletedList
		ret = []
		todos = Todo.where(isCompleted: false)
		todos.each do |todo|
			tmp_todo = todo.as_json
			tmp_todo[:tag_list] = todo.tag_list
			ret << tmp_todo
		end
		render json: ret 
	end

	def todosOf
		ret = []
		selectedTodos = params[:selectedTodos].split(',')
		selectedTodos.each do |id|
			ret << Todo.find(id)
		end
		render json: ret 
	end

	def create
		todo = Todo.new
		todo.goal = params[:goal]
		todo.from = params[:from]
		todo.tag_list = params[:category]
		todo.to = params[:to]
		todo.isCompleted = false
		todo.save
		render json: todo
	end

	def complete 
		selectedTodos = params[:selectedTodos].split(',')

		@log = Log.new
		@log.body = params[:log]
		@log.save

		selectedTodos.each do |id|
			todo = Todo.find(id)
			# 확신 : 남은 todo의 from은 무조건 오늘 이후다. 로그인 할 때, 미완 계획 체크 후, from을 다 오늘로 맞출거다
			if Date.today.month == todo.from.month and Date.today.day < todo.to.day
				# 여기 들어오는 애들은 반복 계획(적어도 오늘 이후까지 반복이 되는 아이들)
				# 해당 todo의 from을 1 증가 시키고
				# copy todo를 만들어 isCompleted시키고, copy todo의 to를 오늘로 만든다
			elsif Date.today.month == todo.from.month and Date.today.day == todo.to.day and todo.from == todo.to
				# 1일만 남은 계획	
				# 해당 todo를 isCompleted 시키면 된다
			else 
				# exception?
			end
			todo.isCompleted = true
			todo.log_id = @log.id
			todo.save
		end
		
		render json: selectedTodos 
	end

end
