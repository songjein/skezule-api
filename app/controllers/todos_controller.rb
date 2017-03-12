class TodosController < ApplicationController
	def index
		todos = Todo.all
		render json: todos
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

end
