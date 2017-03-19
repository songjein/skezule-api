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
			todo.isCompleted = true
			todo.log_id = @log.id
			todo.save
		end
		
		render json: selectedTodos 
	end

end
