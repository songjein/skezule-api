Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :todos

	get '/todosOf/:selectedTodos' => 'todos#todosOf'
	post '/todos/complete' => 'todos#complete'

	resources :logs
end
