class TodosController < ApplicationController
	def index
		todos = Todo.where(isCompleted: false)
		render json: todos
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
