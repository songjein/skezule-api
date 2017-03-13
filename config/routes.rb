Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :todos
	post '/complete' => 'todos#complete'

	get '/todosOf/:selectedTodos' => 'todos#todosOf'
	get '/notCompletedList' => 'todos#notCompletedList'

	resources :logs
end
