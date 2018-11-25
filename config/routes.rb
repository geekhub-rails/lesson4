Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#create'
  post 'tasks/share', to: 'tasks#share'
  get 'users/registration', to: 'users#registration'
  get 'index', to: 'welcome#index'
  root 'tasks#index'
  get 'users/:user_id/tasks', to: 'tasks#index'
  namespace 'admin' do
    get 'dashbpar'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session
  resources :tasks
end
