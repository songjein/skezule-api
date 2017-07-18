class TodosController < ApplicationController
	# 완료/비완료 계획 모두 보여주기
	def index
		ret = []
		todos = @current_user.todos 
		todos.each do |todo|
			tmp_todo = todo.as_json
			tmp_todo[:tag_list] = todo.tag_list
			ret << tmp_todo
		end
		render json: ret 
	end
	
	# list 컴포넌트에 미완료 계획을 보여줄 때 호출
	# 미완료 라는 것의 표현이 약간 애매할 수도 있다. (중간에 의미의 변경이 있었기 때문에)
	# 여기서 '미완료'란 아직 계획 달성의 여부가 남아있는 것을 의미한다
	def notCompletedList
		ret = []
		# 목표의 to 날짜가, 오늘 이후(포함)인 것들 만을 보여준다
		todos = @current_user.todos.each do |t|
			# 계획의 달성 목록 중에서, 오늘 달성한게 있다면 제외시켜야 됌!
			already_done_today = false
			t.complete_todos.each do |c|
				if c.created_at.to_date	== Date.today.to_date
					already_done_today = true
					break
				end
			end

			if not already_done_today and t.to >= Date.today
				tmp_todo = t.as_json
				tmp_todo[:tag_list] = t.tag_list
				ret << tmp_todo
			end
			# 효율을 위해서 else 인 todo는 isCompleted을 false로 만들고
			# (isCompleted의 원래 용도는 한 계획의 달성 여부였다. 그러나 
			# 범위 계획의 경우엔 부분적으로 달성될 수도 있는 부분이어서, 의미를 변경했다)
			# 애초에 todos를 가져올 때 where(isCompleted: false) 조건으로 가지고 온다면
			# 더 효율을 높일 수 있을 것이다
			#todos = @current_user.todos.where(isCompleted: false)
		end
		render json: ret 
	end

	# complete 하기 전에, 계획 텍스트 가져오는 작업
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
		todo.color = params["color"]
		todo.weight = params["weight"]
		todo.user_id = @current_user.id
		todo.save
		render json: todo
	end

	# todos 를 완료하는 단계이다
	# 여러개의 todo가 전달 될 수 있으며
	# 하나의 log로 묶여 달성이 된다.
	# 달성된 각각의 todo는 complete_todo 테이블에 기록이 된다
	# 기본적으로 달성 대상이 되는 todo는 notCompletedList메서드에 의해서
	# todo.to가 오늘 이후라고 확신 할 수 있다
	def complete 
		selectedTodos = params[:selectedTodos].split(',')

		@log = Log.new
		@log.body = params[:log]
		@log.user_id = @current_user.id
		@log.color = params[:color]
		@log.save

		selectedTodos.each do |id|
			todo = Todo.find(id)

			complete_todo = CompleteTodo.new
			complete_todo.todo_id = todo.id
			complete_todo.log_id = @log.id
			complete_todo.save
		end
		
		render json: selectedTodos 
	end
	"""
	def complete 
		selectedTodos = params[:selectedTodos].split(',')

		@log = Log.new
		@log.body = params[:log]
		@log.user_id = @current_user.id
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
	"""
end
