Rails.application.routes.draw do
	root 'tasks#index'
  get '/logout' => 'sessions#destroy'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session
  resources :tasks
end
