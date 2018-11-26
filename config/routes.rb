Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#create'
  get 'users/registration', to: 'users#registration'
  get 'index', to: 'welcome#index'
  root 'tasks#index'
  get 'users/:user_id/tasks', to: 'tasks#index'
  get 'sessions/share', to: 'sessions#share'
  post 'sessions/share', to: 'sessions#find'
  resource :session
  resources :tasks
end
